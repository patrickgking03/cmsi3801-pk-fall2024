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

function first_then_lower_case(array, predicate)
  local first = nil
  for _, s in ipairs(array) do
    if predicate(s) then
      first = s
      break
    end
  end
  if first == nil then
    return nil
  end
  return string.lower(first)
end

function powers_generator(base, limit)
  local power = 1
  return coroutine.create(function()
    while power <= limit do
      coroutine.yield(power)
      power = power * base
    end
  end)
end

function say(word)
  if word == nil then
    return ""
  end
  return function(next)
    if next == nil then
      return word
    else
      return say(word .. " " .. next)
    end
  end
end

function meaningful_line_count(filename)
  local count = 0
  local file = io.open(filename, 'r')
  if file == nil then
    error("No such file")
  end
  for line in file:lines() do
    line = line:match "^%s*(.*)"
    if line ~= "" and line:sub(1, 1) ~= "#" then
        count = count + 1
    end
  end
  file:close()
  return count
end

Quaternion = (function (class)
  local meta = {
    __add = function(self, q)
      return class.new(self.a + q.a, self.b + q.b, self.c + q.c, self.d + q.d)
    end,
    __mul = function(self, q)
      return class.new(
        q.a * self.a - q.b * self.b - q.c * self.c - q.d * self.d,
        q.a * self.b + q.b * self.a - q.c * self.d + q.d * self.c,
        q.a * self.c + q.b * self.d + q.c * self.a - q.d * self.b,
        q.a * self.d - q.b * self.c + q.c * self.b + q.d * self.a
      )
    end,
    __eq = function(self, q)
      return self.a == q.a and self.b == q.b and self.c == q.c and self.d == q.d
    end,
    __tostring = function(self)
      local s = ""
      for i, c in ipairs(self:coefficients()) do
        if c ~= 0 then
          s = s .. (c < 0 and "-" or s == "" and "" or "+")
          s = s .. ((i ~= 1 and math.abs(c) == 1) and "" or tostring(math.abs(c)))
          s = s .. ({"", "i", "j", "k"})[i]
        end
      end
      return s == "" and "0" or s
    end,
    __index = {
      coefficients = function(self)
        return {self.a, self.b, self.c, self.d}
      end,
      conjugate = function(self)
        return class.new(self.a, -self.b, -self.c, -self.d)
      end
    },
  }
  class.new = function (a, b, c, d)
    return setmetatable({a = a, b = b, c = c, d = d}, meta)
  end
  return class
end)({})