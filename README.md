# 🚀 TERMUX-X-NVIM

A fully featured, minimal, and beautiful **Neovim** configuration built on [LazyVim](https://lazyvim.github.io), designed to run on **Termux** (Android). Transparent UI, Org-mode support, LSP for web + Python, and a clean keyboard-driven workflow — all on your phone.

---

## 📋 Table of Contents

- [Installing Termux on Android](#-installing-termux-on-android)
- [Installing Neovim in Termux](#-installing-neovim-in-termux)
- [Cloning and Setting Up This Config](#-cloning-and-setting-up-this-config)
- [Vim vs Neovim — What's the Difference?](#-vim-vs-neovim--whats-the-difference)
- [How to Use Vim / Neovim](#-how-to-use-vim--neovim)
- [The Leader Key](#-the-leader-key)
- [All Keybindings](#-all-keybindings)

---

## 📱 Installing Termux on Android

> **Important:** Do NOT install Termux from the Google Play Store. That version is outdated and unmaintained. Always install from the official GitHub releases.

### Step 1 — Download Termux APK from GitHub

1. Open your Android browser and go to:

   ```
   https://github.com/termux/termux-app/releases/latest
   ```

2. Scroll down to **Assets** and download the correct APK for your device:

   | File | Use When |
   |------|----------|
   | `termux-app_v*-arm64-v8a.apk` | Most modern Android phones (64-bit) |
   | `termux-app_v*-armeabi-v7a.apk` | Older 32-bit Android phones |
   | `termux-app_v*-universal.apk` | If unsure — works on all architectures |

3. Tap the downloaded APK to install it. You may need to allow installation from unknown sources in your Android settings.

### Step 2 — First-Time Termux Setup

The very first thing you should do after opening Termux for the first time is grant storage access. This allows Termux to read and write files in your Android storage (Downloads, Documents, etc.):

```bash
termux-setup-storage
```

> A permission dialog will appear — tap **Allow**. Without this, Termux cannot access your phone's internal storage.

Then update the package list and install essential tools:

```bash
pkg update && pkg upgrade -y
pkg install git curl wget -y
```

---

## ⚡ Installing Neovim in Termux

```bash
pkg install neovim -y
```

Also install supporting tools used by this config:

```bash
# Node.js (required for LSP servers, live-server, Copilot)
pkg install nodejs -y

# Python (required for pyright LSP)
pkg install python -y

# Ripgrep (for Telescope live grep)
pkg install ripgrep -y

# Lua formatter (optional but recommended)
pkg install lua-language-server -y

# markdown-toc (for the TOC keymap to work)
npm install -g markdown-toc

# live-server (for the <leader>bs live-reload feature)
npm install -g live-server
```

Verify Neovim is installed:

```bash
nvim --version
```

---

## 📦 Cloning and Setting Up This Config

The easiest way to install is using the included `install.sh` script — it handles everything automatically: backing up any existing config, creating the required directories, cloning the repo, and copying the config into place.

### One-Command Install

```bash
curl -fsSL https://raw.githubusercontent.com/NOTHING-R/TERMUX-X-NVIM/main/install.sh | bash
```

Or if you have already cloned the repo manually:

```bash
bash ~/TERMUX-X-NVIM/install.sh
```

> The script will back up any existing Neovim config to `~/.config/nvim.bak` before making any changes, so nothing is lost.

### Launch Neovim

```bash
nvim
```

On the first launch, **lazy.nvim** (the plugin manager) will automatically bootstrap itself and install all plugins. This may take a minute or two depending on your internet connection. Wait for it to finish, then restart Neovim:

```bash
# Press q to close the lazy.nvim window, then quit and reopen
:qa
nvim
```

Your setup is complete. You should see the custom dashboard.

---

## 🤔 Vim vs Neovim — What's the Difference?

Both **Vim** and **Neovim** are terminal-based text editors built around the same core idea: keyboard-driven editing with modes. Here is how they compare:

| Feature | Vim | Neovim |
|---|---|---|
| Created | 1991 (Bram Moolenaar) | 2014 (community fork) |
| Config Language | Vimscript | Lua (+ Vimscript still works) |
| Plugin Ecosystem | Large but older | Modern, fast, actively growing |
| Built-in LSP | ❌ No | ✅ Yes (Language Server Protocol) |
| Async Support | Limited | Full async, job control |
| Embedded Terminal | Limited | ✅ Full `:terminal` support |
| Treesitter | Plugin only | ✅ Built-in |
| UI Extensions | Minimal | Floating windows, popups, etc. |
| Speed | Fast | Equally fast, often faster plugins |
| Community | Still active | Very active, modern tooling |

**In short:** Neovim is what Vim would be if it were redesigned today. It is fully backwards compatible with Vim — everything you learn in Vim works in Neovim. But Neovim adds a proper Lua API, built-in LSP, Treesitter, and a much richer plugin ecosystem. This config takes full advantage of all of that.

> If you are on Android/Termux, Neovim is the better choice. It is lighter, faster to configure, and has better plugin support for modern development workflows.

---

## 📖 How to Use Vim / Neovim

Vim/Neovim is a **modal editor** — it has multiple modes, and keys do different things depending on which mode you are in. This is the most important concept to understand.

### The Four Core Modes

| Mode | How to Enter | What It's For |
|---|---|---|
| **Normal** | `Esc` or `jj` | Moving around, running commands. This is the default. |
| **Insert** | `i`, `a`, `o`, `I`, `A`, `O` | Typing and editing text like a regular editor |
| **Visual** | `v` (character), `V` (line), `Ctrl-v` (block) | Selecting text |
| **Command** | `:` | Running editor commands (save, quit, etc.) |

### Essential Normal Mode Movements

```
h  j  k  l     ←  ↓  ↑  →   (arrow key replacements)
w              Jump to start of next word
b              Jump back to start of previous word
e              Jump to end of current word
0              Jump to start of line
$              Jump to end of line
gg             Jump to top of file
G              Jump to bottom of file
Ctrl-d         Scroll down half page
Ctrl-u         Scroll up half page
```

### Essential Normal Mode Actions

```
i              Enter Insert mode before cursor
a              Enter Insert mode after cursor
o              Open a new line below and enter Insert mode
O              Open a new line above and enter Insert mode
x              Delete character under cursor
dd             Delete (cut) entire line
yy             Copy (yank) entire line
p              Paste below cursor
u              Undo
Ctrl-r         Redo
/text          Search forward for "text"
n              Jump to next search result
N              Jump to previous search result
```

### Essential Command Mode Commands

```
:w             Save (write) the file
:q             Quit
:wq            Save and quit
:q!            Quit without saving
:e filename    Open a file
:split         Horizontal split
:vsplit        Vertical split
:%s/old/new/g  Find and replace all occurrences
```

### Survival Tip

If you ever feel stuck or lost, **press `Esc` a couple of times** to get back to Normal mode. From Normal mode, you can always run `:q!` to quit without saving.

---

## 🗝️ The Leader Key

The **leader key** is a special prefix key that unlocks a whole layer of custom keybindings. Think of it as a namespace for your personal shortcuts — pressing the leader key by itself does nothing, but pressing it followed by another key triggers a command.

**In this config, the leader key is `Space`.**

So when you see `<leader>w` in a keybinding, that means: press `Space`, then press `w`.

The leader key system keeps your shortcuts organized and conflict-free — Vim's built-in keys are untouched, and all your custom commands live under `Space`.

**Example flow:**

```
Space → e          Opens the file explorer (Neo-tree)
Space → f → f      Maximize/fullscreen current window
Space → w → v      Split window vertically
```

> Which-key is installed in this config. If you press `Space` and pause for a moment, a popup will appear showing all available commands — you never need to memorize everything at once.

---

## ⌨️ All Keybindings

### 🔑 Escape & Basic

| Key | Mode | Action |
|---|---|---|
| `jj` | Insert | Exit Insert mode (same as `Esc`) |
| `jj` | Terminal | Exit terminal mode |
| `Esc` | Terminal | Exit terminal mode |
| `Ctrl-Backspace` | Insert | Delete previous word |
| `Ctrl-H` | Insert | Delete previous word (fallback) |
| `Tab` | Normal | Toggle fold open/closed |

---

### 📁 File & Search (`<leader>f`)

| Key | Action |
|---|---|
| `<leader><Space>` | Find files from git root (Telescope) |
| `<leader>fs` | Fuzzy search inside current buffer (Swiper-like) |
| `<leader>faa` | Find files in `~/my-shared-fiels/Progrmain Notes/` |
| `<leader>fhf` | Open Hyprland config folder |
| `<leader>.` | File browser in current file's directory |
| `<leader>J` | Open Netrw (`:Ex`) with path prompt |

---

### 🗂️ Buffer Management (`<leader>b` / `<leader>h`)

| Key | Action |
|---|---|
| `<leader>j` | Go to previous buffer |
| `<leader>k` | Go to next buffer |
| `<leader>hh` | Close / kill current buffer |
| `<leader>bi` | Show buffer list (most recently used first) |

---

### 🪟 Window Management (`<leader>w`)

| Key | Action |
|---|---|
| `<leader>ww` | Switch to next window |
| `<leader>wv` | Vertical split |
| `<leader>ws` | Horizontal split |
| `<leader>wc` | Close current window |
| `<leader>ff` | Fullscreen / maximize current window (toggle) |

---

### 🌲 File Explorer

| Key | Action |
|---|---|
| `<leader>e` | Toggle Neo-tree (always opens at project root) |
| `-` | Open parent directory in Oil |
| `<leader>oO` | Open current directory in Oil |

**Inside Neo-tree:**

| Key | Action |
|---|---|
| `h` or `Backspace` | Go up to parent directory |
| `l` or `Enter` | Open file or folder |
| `H` | Toggle hidden files |
| `.` | Set current folder as root |
| `a` | Create new file |
| `A` | Create new directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy |
| `m` | Move |
| `Ctrl-r` | Clear clipboard |

---

### 💻 Terminal

| Key | Action |
|---|---|
| `Ctrl-/` | Toggle split terminal (bottom, 50% height) |
| `Ctrl-.` | Toggle floating terminal (95% screen) |

---

### 🔍 Telescope / Search

| Key | Action |
|---|---|
| `<leader><Space>` | Find files from git root |
| `<leader>fs` | Fuzzy find in current buffer |
| `<leader>bi` | List open buffers |
| `<leader>.` | File browser in current directory |
| `<leader>faa` | Find files in Notes folder |

---

### 📋 UI Toggles (`<leader>t` / `<leader>u`)

| Key | Action |
|---|---|
| `<leader>ts` | Toggle statusline (bottom bar) |
| `<leader>ut` | Toggle bufferline (tab bar at top) |
| `<leader>uu` | Toggle both — ultra minimal mode |
| `<leader>nn` | Scroll current line to top of screen (`zt`) |

---

### 🗒️ Markdown (`<leader>m`)

| Key | Action |
|---|---|
| `<leader>mtt` | Insert or update Table of Contents in current Markdown file |
| `;` (Insert, empty line) | Insert a fenced code block ` ``` ``` ` at cursor |

---

### 🌿 Org Mode (`<leader>z` for Zola exports)

| Key | Action |
|---|---|
| `<leader>ze` | Export current `.org` file to Zola-compatible Markdown |
| `<leader>zy` | Insert a YouTube embed HTML block |
| `<leader>zv` | Insert a local video HTML block |
| `<leader>zj` | Insert an image HTML block |

**Org user commands (run with `:`):**

| Command | Action |
|---|---|
| `:OrgExportZola` | Export `.org` → `.md` with TOML front matter |
| `:ZolaYouTube` | Insert YouTube embed template |
| `:ZolaVideo` | Insert video embed template |
| `:ZolaImage` | Insert image template |

---

### 🔭 Code / LSP / Outline

| Key | Action |
|---|---|
| `<leader>oo` | Toggle symbol outline panel (functions, classes, etc.) |
| `<leader>ll` | Open Lazy plugin manager |
| `<leader>hk` | Open Vim help |
| `<leader>hm` | Show messages (`:messages`) |

---

### 🖥️ Live Server

| Key | Action |
|---|---|
| `<leader>bs` | Start live-server (auto-reloads browser on save) |
| `<leader>bx` | Stop live-server |

---

### 🎬 Media

| Key | Action |
|---|---|
| `<leader>ov` | Open the file path under cursor with `mpv` (video player) |

---

### 🔀 Tmux Navigation

These work seamlessly across Neovim splits and Tmux panes:

| Key | Action |
|---|---|
| `Ctrl-h` | Move to left pane / split |
| `Ctrl-j` | Move to pane / split below |
| `Ctrl-k` | Move to pane / split above |
| `Ctrl-l` | Move to right pane / split |
| `Ctrl-\` | Move to previous pane |

---

### ✂️ Snippets

| Key | Mode | Action |
|---|---|---|
| `Ctrl-j` | Insert / Select | Expand snippet or jump to next field |
| `Ctrl-k` | Insert / Select | Jump to previous snippet field |

**Available snippet prefix:**

| Prefix | Language | Expands To |
|---|---|---|
| `rfce` | JS / TS / JSX / TSX | React Functional Component with default export |

---

### 🎨 Colorscheme & Highlights

The colorscheme is **Tokyo Night** with full transparency. Markdown headings (H1–H6) are highlighted with custom colors loaded from `active-colorscheme.sh`. Background groups like `Normal`, `NeoTree`, `Telescope`, and `FloatBorder` are all set to transparent automatically on every colorscheme change.

---

## 📂 Config Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lazyvim.json              # LazyVim extras (Copilot, Markdown, Python, Tailwind)
├── stylua.toml               # Lua formatter settings
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # Plugin manager bootstrap
│   │   ├── options.lua       # Editor options
│   │   ├── keymaps.lua       # Custom keybindings
│   │   ├── autocmds.lua      # Auto-commands (auto-save, highlights, etc.)
│   │   ├── toggles.lua       # UI toggle system (statusline / bufferline)
│   │   ├── highlights.lua    # Markdown heading colors
│   │   ├── colors.lua        # Color loader from active-colorscheme.sh
│   │   ├── markdown.lua      # TOC generation function
│   │   └── orgextra.lua      # Org → Zola export + HTML templates
│   └── plugins/
│       ├── tokyonight.lua    # Colorscheme (transparent)
│       ├── dashboard.lua     # Custom startup screen
│       ├── lsp.lua           # Language servers (html, css, ts, py, lua, md)
│       ├── treesitter.lua    # Syntax + JSX auto-tag
│       ├── neotree.lua       # File explorer
│       ├── oil.lua           # Directory editor
│       ├── telescope_buffer.lua  # Fuzzy finder + file browser
│       ├── floaterm.lua      # Floating / split terminal
│       ├── snacks.lua        # Indent guides
│       ├── topbar.lua        # Bufferline + lualine (hidden by default)
│       ├── snippets.lua      # LuaSnip + custom snippets
│       ├── orgmode.lua       # Org-mode support
│       ├── render-markdown.lua   # Pretty markdown rendering
│       ├── autopair.lua      # Auto-close brackets/quotes
│       ├── tmux.lua          # Tmux pane navigation
│       ├── outline.lua       # Code symbol outline
│       ├── live-server.lua   # Browser live-reload
│       ├── fullscreen.lua    # Window maximize
│       ├── noice.lua         # (disabled)
│       └── copilot.lua       # (disabled/commented out)
└── snippets/
    ├── javascript.json
    ├── javascriptreact.json
    ├── typescript.json
    └── typescriptreact.json
```

---

## 🧩 Installed Language Servers (LSP)

| Language | Server |
|---|---|
| HTML | `html` |
| CSS / SCSS / Less | `cssls` + `emmet_language_server` |
| Tailwind CSS | `tailwindcss` |
| JavaScript / TypeScript / React | `vtsls` |
| Python | `pyright` |
| Markdown | `marksman` |
| Lua (Neovim config) | `lua_ls` |

---

## 📜 License

MIT — see [LICENSE](LICENSE) for details.
