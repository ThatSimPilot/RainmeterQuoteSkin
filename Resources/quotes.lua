quotes = {
    
}

function GetQuote()
    local day = tonumber(os.date("%j")) -- day of year (1–365)
    local index = (day % #quotes) + 1
    local q = quotes[index]

    SKIN:Bang("!SetVariable", "QuoteText", q.text)
    SKIN:Bang("!SetVariable", "QuoteAuthor", q.author)
    SKIN:Bang("!SetVariable", "QuoteSize", q.size or 26)
    SKIN:Bang("!SetVariable", "QuoteColor", q.color or "255,255,255")
end