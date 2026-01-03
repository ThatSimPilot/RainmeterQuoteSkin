-- quotes.lua
-- Auto-generated style template for your Rainmeter Quote Skin
-- Exposes: Initialize(), GetQuote(), Update()
--
-- Expected by your quotes.ini:
--   [MeasureQuotes]
--   Measure=Script
--   ScriptFile=#@#Scripts\quotes.lua
--
-- And called via:
--   OnRefreshAction=[!CommandMeasure MeasureQuotes "GetQuote()"]

-- Replace or extend this table with your generated quotes.
-- Each entry supports:
--   text      (string, required)
--   by        (string, optional)
--   font      (string, optional)  e.g. "Segoe UI", "Segoe Script"
--   color     (table, optional)   {r,g,b}
--   align     (string, optional)  "left"|"center"|"right"|"justify"
--   byAlign   (string, optional)  "left"|"center"|"right"
quotes = quotes or {
  {
    text = 'Enjoy the butterflies. Enjoy being naive. Enjoy the nerves, the pressure, people not knowing your name, all that stuff.',
    by = "Daniel Ricciardo",
    font = "Segoe Script",
    color = {255, 255, 255},
    align = "left",
    byAlign = "left"
  }
}

local function clampAlign(a)
  if a == "left" or a == "center" or a == "right" or a == "justify" then return a end
  return "left"
end

local function clampByAlign(a)
  if a == "left" or a == "center" or a == "right" then return a end
  return "right"
end

local function safeColor(c)
  if type(c) == "table" and tonumber(c[1]) and tonumber(c[2]) and tonumber(c[3]) then
    local r = math.floor(tonumber(c[1]) or 255)
    local g = math.floor(tonumber(c[2]) or 255)
    local b = math.floor(tonumber(c[3]) or 255)
    if r < 0 then r = 0 elseif r > 255 then r = 255 end
    if g < 0 then g = 0 elseif g > 255 then g = 255 end
    if b < 0 then b = 0 elseif b > 255 then b = 255 end
    return r, g, b
  end
  return 255, 255, 255
end

local function chooseQuoteIndex()
  local n = #quotes
  if n <= 0 then return nil end

  -- Day-of-year rotation (1..366). This matches your generator logic.
  local day = tonumber(os.date("%j")) or 1
  local idx = (day % n) + 1
  return idx
end

function Initialize()
  -- You can preload a quote here if you want, but your INI already calls GetQuote() on refresh.
end

function GetQuote()
  if type(quotes) ~= "table" or #quotes == 0 then
    SKIN:Bang("!SetVariable", "QuoteText", "No quotes found.")
    SKIN:Bang("!SetVariable", "QuoteAuthor", "")
    SKIN:Bang("!SetVariable", "QuoteFont", "Segoe UI")
    SKIN:Bang("!SetVariable", "QuoteColor", "255,255,255")
    SKIN:Bang("!SetVariable", "QuoteSize", "26")
    SKIN:Bang("!SetVariable", "QuoteAlign", "left")
    SKIN:Bang("!SetVariable", "QuoteByAlign", "right")
  else
    local idx = chooseQuoteIndex()
    local q = quotes[idx] or quotes[1]

    local text = q.text or ""
    local by = q.by or ""
    local font = q.font or "Segoe Script"
    local r, g, b = safeColor(q.color)
    local align = clampAlign(q.align)
    local byAlign = clampByAlign(q.byAlign)

    -- Set variables used by your meters
    SKIN:Bang("!SetVariable", "QuoteText", text)
    SKIN:Bang("!SetVariable", "QuoteAuthor", by)
    SKIN:Bang("!SetVariable", "QuoteFont", font)
    SKIN:Bang("!SetVariable", "QuoteColor", string.format("%d,%d,%d", r, g, b))
    SKIN:Bang("!SetVariable", "QuoteSize", "26")
    SKIN:Bang("!SetVariable", "QuoteAlign", align)
    SKIN:Bang("!SetVariable", "QuoteByAlign", byAlign)
  end

  -- Force the meters to refresh after changing variables
  SKIN:Bang("!UpdateMeter", "MeterQuote")
  SKIN:Bang("!UpdateMeter", "MeterAuthor")
  SKIN:Bang("!Redraw")
end

function Update()
  -- Return a number; Rainmeter expects this.
  return 0
end
