# Rainmeter Quote Skin Generator

A lightweight web-based tool and Rainmeter skin that displays a **random motivational quote** on your Windows desktop.

The skin supports:
- Random quote on every skin refresh or system boot
- Automatic daily quote rotation
- Custom fonts, colours, and text alignment
- A visual quote editor that exports a ready-to-use `quotes.lua`

Built for simplicity, reliability, and zero external dependencies inside Rainmeter.

Quotes can be edited at https://thatsimpilot.github.io/RainmeterQuoteSkin/

---

## Features

- 🎯 Random quote on refresh or load
- 📅 Automatically changes quote once per day
- 🔁 Prevents repeating quotes until all have been shown
- ✍️ Quote editor with live preview
- 🎨 Per-quote font, colour, and alignment support
- 📦 Exports a single `quotes.lua` file for Rainmeter
- 🧠 Deterministic daily selection (same quote all day, every day)

---

## Project Structure

.
├── index.html # Web-based quote editor
├── js/
│ └── app.js # Generator logic and Lua exporter
├── quotes.lua # Rainmeter script (generated)
├── quotes.ini # Rainmeter skin config
└── README.md


---

## Requirements

- Windows
- Rainmeter (latest stable recommended)
- A modern browser (Chrome, Edge, Firefox)

---

## Installation

### Option 1: Using the `.rmskin` (recommended)

1. Download the latest `.rmskin` release.
2. Install it via Rainmeter.
3. Generate your `quotes.lua` using the web tool.
4. Replace the installed file at: `Documents\Rainmeter\Skins\RainmeterQuoteSkin\Resources\Scripts\quotes.lua`
5. Refresh the skin in Rainmeter.

---

### Option 2: Manual Install

1. Copy the skin folder into: `Documents\Rainmeter\Skins\`
2. Load the skin in Rainmeter.
3. Replace `quotes.lua` with your generated file.
4. Refresh.

---

## How the Quote Logic Works

- **On refresh or load**
  - A new random quote is selected (if enabled).
- **Daily rotation**
  - At midnight, the skin switches to a new daily base quote.
- **Persistence**
  - State is saved so quotes are not repeated until all have been shown.

The logic is handled entirely in Lua and does not rely on external services.

---

## Customisation

You can control behaviour via Rainmeter variables, including:
- Quote position
- Width and alignment
- Refresh behaviour
- Fonts and colours

Each quote entry supports:
- Text
- Author
- Font
- Colour (RGB)
- Quote alignment
- Author alignment

---

## Development Notes

- No frameworks required
- Uses plain JavaScript, HTML, and Lua
- Lua logic is intentionally defensive to avoid Rainmeter crashes
- Generator output is deterministic and Rainmeter-safe

---

## License
Code and logic are licensed under the MIT License -> See `LICENCE-MIT`.
Skin layout and visual presentation are licensed under Creative Commons Attribution 4.0 -> See `LICENSE-CC`.