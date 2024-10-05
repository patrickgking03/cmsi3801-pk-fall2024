function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(sequence, predicate)
  for _, str in ipairs(sequence) do
    if predicate(str) then
      return string.lower(str)
    end
  end
  return nil
end

-- Write your powers generator here
function powers_generator(base, limit)
  return coroutine.create(function()
    local power = 1
    while power <= limit do
      coroutine.yield(power)
      power = power * base
    end
  end)
end

-- Write your say function here
function say(word)
  local sentence = word or ""

  return function(next_word)
    if next_word == nil then
      return sentence
    elseif next_word == "" then
      sentence = sentence .. " "
    else
      if sentence ~= "" then
        sentence = sentence .. " " .. next_word
      else
        sentence = next_word
      end
    end
    return say(sentence)
  end
end

-- Write your line count function here
function meaningful_line_count(filename)
  local file = io.open(filename, "r")
  
  if not file then
    error("No such file")
  end
  
  local count = 0
  for line in file:lines() do
    if line:match("^%s*$") == nil and line:match("^%s*#") == nil then
      count = count + 1
    end
  end
  
  file:close()
  return count
end

-- Write your quaternion class here
Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(a, b, c, d)
  local self = setmetatable({}, Quaternion)
  self.a = a
  self.b = b
  self.c = c
  self.d = d
  return self
end

function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end

function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion.__add(q1, q2)
  return Quaternion.new(
    q1.a + q2.a, 
    q1.b + q2.b, 
    q1.c + q2.c, 
    q1.d + q2.d
  )
end

function Quaternion.__mul(q1, q2)
  local a = q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d
  local b = q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c
  local c = q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b
  local d = q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
  return Quaternion.new(a, b, c, d)
end

function Quaternion.__eq(q1, q2)
  return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

function Quaternion:__tostring()
  local parts = {}

  if self.a ~= 0 then 
    table.insert(parts, tostring(self.a)) 
  end

  if self.b ~= 0 then 
    local sign = (self.b > 0 and (#parts > 0 and "+" or "") or "") 
    table.insert(parts, sign .. (math.abs(self.b) == 1 and "i" or tostring(self.b) .. "i")) 
  end

  if self.c ~= 0 then 
    local sign = (self.c > 0 and (#parts > 0 and "+" or "") or "") 
    table.insert(parts, sign .. (math.abs(self.c) == 1 and "j" or tostring(self.c) .. "j")) 
  end

  if self.d ~= 0 then 
    local sign = (self.d > 0 and (#parts > 0 and "+" or "") or "") 
    table.insert(parts, sign .. (math.abs(self.d) == 1 and "k" or tostring(self.d) .. "k")) 
  end

  if #parts == 0 then 
    return "0" 
  end
  
  return table.concat(parts)
end