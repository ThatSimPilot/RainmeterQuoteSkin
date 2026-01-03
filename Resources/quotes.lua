-- quotes.lua
-- Rainmeter Quote Skin script
-- Exposes: Initialize(), GetQuote(), Update()

-- IMPORTANT:
-- Avoid curly quotes (’ “ ”) in strings unless you're 100% sure Rainmeter is reading UTF-8 correctly.
-- Use straight quotes/apostrophes instead: ' and ".

quotes = quotes or {
  {
    text = "If you no longer go for a gap that exists, you're no longer a racing driver.",
    by = "Ayrton Senna",
    font = "Segoe Script",
    color = {255, 255, 255},
    align = "center",   -- left | center | right | justify
    byAlign = "center"  -- left | center | right
  }
}

local function safeNumber(v, fallback)
  local n = tonumber(v)
  if n == nil then return fallback end
  return n
end

local function safeColor(c)
  if type(c) == "table" then
    local r = math.floor(safeNumber(c[1], 255))
    local g = math.floor(safeNumber(c[2], 255))
    local b = math.floor(safeNumber(c[3], 255))
    if r < 0 then r = 0 elseif r > 255 then r = 255 end
    if g < 0 then g = 0 elseif g > 255 then g = 0 elseif g > 255 then g = 255 end
    if b < 0 then b = 0 elseif b > 255 then b = 255 end
    return r, g, b
  end
  return 255, 255, 255
end

local function toTopAlign(a, default)
  a = (a or default or "left"):lower()
  if a == "center" then return "CenterTop" end
  if a == "right" then return "RightTop" end
  -- Rainmeter doesn't really support "justify" as a StringAlign mode.
  -- We'll keep it as LeftTop so it renders consistently.
  return "LeftTop"
end

local function computeXPos(alignTop, baseX, width)
  if alignTop == "CenterTop" then return baseX + (width / 2) end
  if alignTop == "RightTop" then return baseX + width end
  return baseX
end

local function chooseQuoteIndex()
  local n = #quotes
  if n <= 0 then return nil end

  -- Day-of-year rotation
  local day = tonumber(os.date("%j")) or 1
  local idx = (day % n) + 1
  return idx
end

function Initialize()
  -- You can call GetQuote() here too, but OnRefreshAction already does it.
end

function GetQuote()
  local baseX = safeNumber(SKIN:GetVariable("QuoteX"), 20)
  local width = safeNumber(SKIN:GetVariable("QuoteW"), 520)

  if type(quotes) ~= "table" or #quotes == 0 then
    SKIN:Bang("!SetVariable", "QuoteText", "No quotes found.")
    SKIN:Bang("!SetVariable", "QuoteAuthor", "")
    SKIN:Bang("!SetVariable", "QuoteFont", SKIN:GetVariable("DefaultFont") or "Segoe UI")
    SKIN:Bang("!SetVariable", "QuoteSize", SKIN:GetVariable("DefaultSize") or "28")
    SKIN:Bang("!SetVariable", "QuoteColor", SKIN:GetVariable("DefaultColor") or "255,255,255")
    SKIN:Bang("!SetVariable", "QuoteAlign", "LeftTop")
    SKIN:Bang("!SetVariable", "QuoteByAlign", "LeftTop")
    SKIN:Bang("!SetVariable", "QuoteXPos", tostring(baseX))
    SKIN:Bang("!SetVariable", "ByXPos", tostring(baseX))
  else
    local idx = chooseQuoteIndex()
    local q = quotes[idx] or quotes[1]

    local text = q.text or ""
    local by = q.by or ""
    local font = q.font or (SKIN:GetVariable("DefaultFont") or "Segoe UI")
    local r, g, b = safeColor(q.color)

    local quoteAlignTop = toTopAlign(q.align, "left")
    local byAlignTop = toTopAlign(q.byAlign, "left")

    local quoteXPos = computeXPos(quoteAlignTop, baseX, width)
    local byXPos = computeXPos(byAlignTop, baseX, width)

    SKIN:Bang("!SetVariable", "QuoteText", text)
    SKIN:Bang("!SetVariable", "QuoteAuthor", by)
    SKIN:Bang("!SetVariable", "QuoteFont", font)
    SKIN:Bang("!SetVariable", "QuoteSize", SKIN:GetVariable("DefaultSize") or "28")
    SKIN:Bang("!SetVariable", "QuoteColor", string.format("%d,%d,%d", r, g, b))
    SKIN:Bang("!SetVariable", "QuoteAlign", quoteAlignTop)
    SKIN:Bang("!SetVariable", "QuoteByAlign", byAlignTop)
    SKIN:Bang("!SetVariable", "QuoteXPos", tostring(quoteXPos))
    SKIN:Bang("!SetVariable", "ByXPos", tostring(byXPos))
  end

  -- Force meters to refresh after variable changes
  SKIN:Bang("!UpdateMeter", "MeterQuote")
  SKIN:Bang("!UpdateMeter", "MeterAuthor")
  SKIN:Bang("!Redraw")
end

function Update()
  return 0
end
