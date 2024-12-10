#include "string_stack.h"
#include <stdlib.h>
#include <string.h>

// structure of the stack
struct _Stack {
    char** data;       // pointer to stack's elements
    int capacity;      // maximum number of elements that fit
    int count;         // current number of elements in stack
};

// initializes new stack and sets up fields
stack_response create() {
    stack_response response;
    stack my_stack = (stack)malloc(sizeof(struct _Stack));

    if (!my_stack) {
        response.code = out_of_memory;
        response.stack = NULL;
        return response;
    }

    my_stack->capacity = 16;
    my_stack->count = 0;
    my_stack->data = (char**)malloc(my_stack->capacity * sizeof(char*));

    if (!my_stack->data) {
        free(my_stack);
        response.code = out_of_memory;
        response.stack = NULL;
        return response;
    }

    response.code = success;
    response.stack = my_stack;
    return response;
}

// cleans up memory allocated for stack
void destroy(stack* s) {
    if (!s || !*s) return;

    for (int i = 0; i < (*s)->count; i++) {
        free((*s)->data[i]);
    }

    free((*s)->data);
    free(*s);
    *s = NULL;
}

// returns number of elements in stack
int size(const stack s) {
    return s->count;
}

// checks if stack is empty
bool is_empty(const stack s) {
    return s->count == 0;
}

// checks if stack has reached maximum capacity
bool is_full(const stack s) {
    return s->capacity == MAX_CAPACITY && s->count == s->capacity;
}

// adds new element to stack
response_code push(stack s, char* item) {
    if (!s || strlen(item) >= MAX_ELEMENT_BYTE_SIZE) return stack_element_too_large;

    // resize if necessary
    if (s->count == s->capacity) {
        if (s->capacity >= MAX_CAPACITY) return stack_full;

        int new_capacity = s->capacity * 2;
        if (new_capacity > MAX_CAPACITY) new_capacity = MAX_CAPACITY;

        char** new_data = (char**)realloc(s->data, new_capacity * sizeof(char*));
        if (!new_data) return out_of_memory;

        s->data = new_data;
        s->capacity = new_capacity;
    }

    // store a copy of string
    s->data[s->count] = strdup(item);
    if (!s->data[s->count]) return out_of_memory;

    s->count++;
    return success;
}

// removes & returns top element of stack
string_response pop(stack s) {
    string_response response;
    if (!s || s->count == 0) {
        response.code = stack_empty;
        response.string = NULL;
        return response;
    }

    response.code = success;
    response.string = s->data[--s->count];

    // shrink capacity if necessary
    if (s->count < s->capacity / 4 && s->capacity > 16) {
        int new_capacity = s->capacity / 2;
        if (new_capacity < 16) new_capacity = 16;

        char** new_data = (char**)realloc(s->data, new_capacity * sizeof(char*));
        if (new_data) {
            s->data = new_data;
            s->capacity = new_capacity;
        }
    }

    return response;
}