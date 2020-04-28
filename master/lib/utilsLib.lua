--- provides a few helpful functions
-- @module utilsLib
local utilsLib = {}

local ipairs = ipairs
local string = string
local table = table
local tonumber = tonumber
local tostring = tostring
local type = type

_ENV = utilsLib

--- checkStrIsBool checks if the specified string is a boolean
-- @param string to be checked
-- @tparam string
-- @return true, or false
local function checkStrIsBool(string)
  return string == 'true' or string == 'false'
end

--- checkStrIsNum checks in the specified string is a number
-- @param string to be checked
-- @tparam string
-- @return true, or false
local function checkStrIsNum(string)
  return tonumber(string) ~= nil
end

--- checkCharInStr checks if the specified character in string
-- @param char character to check
-- @tparam string
-- @param string to be checked
-- @tparam string
-- @return true, or false
local function checkCharInStr(char, string)
  return string.match(string, char) ~= nil
end

--- checkStrInTab checks if string in table
-- @param string to check
-- @tparam string
-- @param table to be checked
-- @tparam table
-- @return true, or false
function utilsLib.checkStrInTab(string, table)
  for _, val in ipairs(table) do
    if val == string then
      return true
    end
  end
  return false
end

--- splitStrAtChar splits the string at the specified character (excluded)
-- @param char character to split the string at (exluded)
-- @tparam string
-- @param string to be split
-- @tparam string
-- @return string before the specified character, or string
-- @return string after the specified character, or nil
local function splitStrAtChar(char, string)
  if checkCharInStr(char, string) then
    return string.match(string, '(.-)' .. char .. '(.*)')
  else
    return string, nil
  end
end

--- splitStrAtColon splits a string at ':' (excluded)
-- @param string to be split
-- @tparam string
-- @return string before ':', or string
-- @return string after ':', or nil
function utilsLib.splitStrAtColon(string)
  return splitStrAtChar(':', string)
end

--- splitStrAtCharNum splits a string at the specified character number
-- @param string to be split
-- @tparam string
-- @param charNum character number for string to be split
-- @tparam number
-- @return string before specified charNum
-- @return string after specified charNum
function utilsLib.splitStrAtCharNum(string, charNum)
  return string.match(string, '(.-' .. string.rep('.', charNum) .. ')(.*)')
end

--- multiSplitStrAtChar splits the string at each specified character
---(excluded)
-- @param char character to split the string at (excluded)
-- @tparam string
-- @param string to be split
-- @tparam string
-- @return table of string splits, or table of string, or empty table
local function multiSplitStrAtChar(char, string)
  local stringList = {}
  if type(string) == 'string' and checkCharInStr(char, string) then
    for str in string.gmatch(string, '[^' .. char .. ']+') do
      table.insert(stringList, str)
    end
  elseif type(string) == 'string' then
    table.insert(stringList, string)
  end
  return stringList
end

--- multiSplitStrAtColon splits a string at each ':' (excluded)
-- @param string to be split
-- @tparam string
-- @return table of string splits, or table of string, or empty table
function utilsLib.multiSplitStrAtColon(string)
  return multiSplitStrAtChar(':', string)
end

--- multiSplitStrAtSemiColon splits a string at each ';' (excluded)
-- @param string to be split
-- @tparam string
-- @return table of string splits, or table of string, or empty table
function utilsLib.multiSplitStrAtSemiColon(string)
  return multiSplitStrAtChar(';', string)
end

--- fmtTabVals formats a table of strings to their respective value types
-- @param table of strings to format
-- @tparam table
-- @return table of strings
local function fmtTabVals(table)
  local valueTab = {}
  for _, str in ipairs(table) do
    if checkStrIsBool(str) then
      if str == 'true' then
        table.insert(valueTab, true)
      else
        table.insert(valueTab, false)
      end
    elseif checkStrIsNum(str) then
      table.insert(valueTab, tonumber(str))
    else
      table.insert(valueTab, str)
    end
  end
  return valueTab
end

--- fmtTabAsStr formats a table of value types to a string seperated by ':'
-- @param table of values to format
-- @tparam table
-- @return string
function utilsLib.fmtTabAsStr(table)
  local string = ''
  for i, val in ipairs(table) do
    string = string .. tostring(val)
    if i ~= #table then
      string = string .. ':'
    end
  end
  return string
end

--- runFuncWithArgs executes the specified function with appropriate number of
---arguements
-- @param f function to be executed
-- @tparam function
-- @param argList table of arguements to be passed
-- @tparam table
-- @return relative returns
-- @todo handle more arguements (if required)
function utilsLib.runFuncWithArgs(f, argList)
  local argList = fmtTabVals(argList)
  if #argList == 0 then
    return f()
  elseif #argList == 1 then
    return f(argList[1])
  elseif #argList == 2 then
    return f(argList[1], argList[2])
  elseif #argList == 3 then
    return f(argList[1], argList[2], argList[3])
  elseif #argList == 4 then
    return f(argList[1], argList[2], argList[3], argList[4])
  elseif #argList == 5 then
    return f(argList[1], argList[2], argList[3], argList[4], argList[5])
  elseif #argList == 6 then
    return f(argList[1], argList[2], argList[3], argList[4], argList[5],
      argList[6])
  elseif #argList == 7 then
    return f(argList[1], argList[2], argList[3], argList[4], argList[5],
      argList[6], argList[7])
  elseif #argList == 6 then
    return f(argList[1], argList[2], argList[3], argList[4], argList[5],
      argList[6], argList[7], argList[8])
  else
    -- todo: handle more arguements (if required)
  end
end

return utilsLib
