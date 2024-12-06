package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

// A little utility that simulates performing a task for a random duration.
// For example, calling do(10, "Remy", "is cooking") will compute a random
// number of milliseconds between 5000 and 10000, log "Remy is cooking",
// and sleep the current goroutine for that much time.

func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

// Implement the rest of the simulation here. You may need to add more imports
// above.

// represents an order placed by customer
type Order struct {
	id         uint64      // unique order ID
	customer   string      // customer placing order
	replyChan  chan *Order // channel for cook to send prepared meal
	preparedBy string      // name of cook who prepared the meal
}

// global atomic counter for unique order IDs
var orderCounter atomic.Uint64

// waiter channel to hold up to 3 orders at a time
var waiter = make(chan *Order, 3)

// cook goroutine to process orders
func cook(name string, wg *sync.WaitGroup, shutdown <-chan struct{}) {
	defer wg.Done()
	log.Println(name, "starting work")

	for {
		select {
		case <-shutdown: // exit when restaurant closes
			log.Println(name, "shutting down")
			return
		case order, ok := <-waiter: // process orders if available
			if !ok {
				// waiter channel closed
				return
			}
			do(10, name, "cooking order", order.id, "for", order.customer)
			order.preparedBy = name
			select {
			case order.replyChan <- order: // deliver meal to customer
			case <-shutdown: // exit if shutdown during delivery
				return
			}
		}
	}
}

// customer goroutine to eat 5 meals before leaving
func customer(name string, wg *sync.WaitGroup, shutdown <-chan struct{}) {
	defer wg.Done()

	mealsEaten := 0
	for mealsEaten < 5 {
		select {
		case <-shutdown: // exit early if restaurant closes
			log.Println(name, "leaving early due to restaurant closing")
			return
		default:
			order := &Order{
				id:        orderCounter.Add(1),
				customer:  name,
				replyChan: make(chan *Order, 1),
			}
			log.Println(name, "placed order", order.id)

			// try placing order with the waiter, with a 7-second timeout
			select {
			case waiter <- order:
				select {
				case meal := <-order.replyChan: // wait for meal
					do(2, name, "eating cooked order", meal.id, "prepared by", meal.preparedBy)
					mealsEaten++
				case <-shutdown: // exit if restaurant closes during meal
					log.Println(name, "leaving while waiting for meal due to restaurant closing")
					return
				}
			case <-time.After(7 * time.Second): // abandon order if waiter is busy
				do(5, name, "waiting too long, abandoning order", order.id)
			}
		}
	}
	log.Println(name, "going home after eating 5 meals")
}

func main() {
	rand.Seed(time.Now().UnixNano()) // seed random number generator

	// configuration
	customers := []string{"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}
	cooks := []string{"Remy", "Colette", "Linguini"}
	var wg sync.WaitGroup
	shutdown := make(chan struct{}) // channel to signal shutdown

	// launch cook goroutines
	for _, cookName := range cooks {
		wg.Add(1)
		go cook(cookName, &wg, shutdown)
	}

	// launch customer goroutines
	for _, customerName := range customers {
		wg.Add(1)
		go customer(customerName, &wg, shutdown)
	}

	// limit the restaurant's runtime to 20 seconds
	time.AfterFunc(20*time.Second, func() {
		log.Println("Restaurant closing")
		close(shutdown) // signal all goroutines to stop
	})

	// wait for all goroutines to finish
	wg.Wait()
	log.Println("Restaurant has closed")
}
