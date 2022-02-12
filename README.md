# dot-emacs

My simple and minimal `.emacs.d` files. Target: `Debian/Ubuntu`.

TLDR:

+ only basic knowledge of Elisp required
+ `use-package` macros and only melpa packages (no external
  dependencies)
+ Emacs daemon (server) + clients
+ LSP (Go, Python, Rust, Javascript, Typescript, LaTeX)
+ use native-comp if available
+ keybindings optimized for Ergodox EZ layout and Regolith (i3)

### ToC

+ [Rationale](#rationale)
  - [Usage](#usage)
  - [Bash functions and aliases](#bash-functions-and-aliases)
+ [Notes](#notes)
+ [LSP servers](#lsp-servers)
  - [Go](#go)
  - [Python](#python)
  - [Rust](#rust)
  - [Javascript and Typescript](#javascript-and-typescript)
  - [LaTeX](#latex)

## Rationale

I mostly spend my daily routine between Chrome, a bash terminal, and
an Emacs Frame. I use to have dedicated workspaces for Chrome and
Emacs. I find [Regolith](https://regolith-linux.org/) a convenient
solution. With Regolith, I can easily share the same setup across many
machines. Moreover, I can minimize all the tasks that require to
interact simultaneously with keyboard and mouse.

I rarely change my Emacs configuration while working. Most of the
changes are made on the days off. So I prefer having a minimal and
easy to use configuration, introducing a new feature only when is
really needed. I used to be an EXWM user. The daily experience was
awesome, but from time to time it required to stop my activies, making
me feel a bit unproductive.

### Usage

On a typical day, I start the Emacs daemon right after boot typing
`start-emacs` in the terminal (see
[here](#bash-functions-and-aliases)). When I want to edit a file or a
directory, I simply type:

+ `et ${PATH}` to open the file with Emacs in the current
  terminal.
+ `ef ${PATH}` to open the file in a new Emacs frame;
+ `efs ${PATH}` to open the file in a new Emacs frame and closing
  the terminal window;

When I need to update my configuration there are two alternatives:
+ if it's just something I want to tweak right on the spot, I open a
  new buffer, type some Elisp and then call `eval-region`. These are
  modifications that do not persist with a restart of the daemon
  (i.e., the server);
+ if it's something more complex, I edit and save the dotfiles, and
   then restart the daemon running on the `kill-emacs; start-emacs`
   commands.
  
### Bash functions and aliases

Add the following to your `.bashrc`

```bash
# open Emacs in terminal
et () { emacsclient -nw "$@"; }

# open a new Emacs frame
ef () { emacsclient -c "$@" & disown; }

# open a new Emacs frame, set Emacs fullscreen, then close the current shell
efs () { emacsclient -F "'(fullscreen . maximized)" -c "$@" & disown; exit;}
```
  
## Notes

This pragmatic use of Emacs has some pros and cons, but I found it
very practical. In the following there is list of considerations and
remarks that might be useful.

+ Why using a daemon and not separate Emacs instances? Packages are
  loaded only once, subsequent frame openings occur instantaneously.

+ Why `use-package`? It is easy to use, and it permits to keep the
  files tidy and readable. There are powerful alternatives as
  `straight.el`, but I don't feel the need to use a package manager
  yet.

+ Why the first boot is _slow_? The first time `init.el` is loaded,
  package archives are fetched, then all the packages are downloaded,
  compiled and loaded.

+ Do you only use packages from melpa and melpa-stable? Yes. When I
  work on a new VM the setup boils down to creating a link to my
  dotfiles and then running the command `start-emacs`.
  
+ Why Regolith? No initial setup cost, and when you need something
  more complex, you can directly edit the i3 configuration. I no
  longer have the same integration I had with EXWM, but in case of
  problem (or when Emacs freezes), I can just kill and restart the
  server instead of the whole X session.
  
+ Why `package-native-compile`? Coding inside a VM with `lsp` is a bit
  laggy. Compiling and installing Emacs with native compilation
  support significantly improves the experience. If native compilation
  is available, `package-native-compile` tells the built-in package
  manager to perform native compilation when installing a package.
  
+ Only Go, Python, Rust, Javascript/Typescript and LaTeX? With huge
  codebases (as the AOSP), I don't want Emacs to perform any
  indexing. On the other hand, when projects are too small, I just
  rely on the built-in capabilities to highlight the syntax. Also
  notice that I tend to rely only on lsp basic functions (without
  changing the default keybindings). In general, I think that
  language-specific command line tools are more convenient when there
  is the need to trace, inspect or debug a project. These tools can be
  neatly arranged into Makefiles, making it easy to reproduce tests on
  different hosts, by different devs.

+ Some commands/keybindings do not work. Yes, there are Emacs packages
  that rely on binaries that need to be available on the host (e.g.,
  direnv). In these cases, I just ensure there are no errors at boot
  time (Emacs installation should not block when the binary isn't
  available).

+ Any updates? I plan to update this public version of the dotfiles
  from time to time. I'm always testing new packages, but I keep them
  only if they really improve my workflow.
  
+ Some keybindings seem unnatural. That's because I use an [Ergodox
EZ](https://ergodox-ez.com/) with a custom layout. It allows me to
write code without ever moving my wrists.

## LSP servers

Here are some notes to configure the language servers.

### Go

+ Install the `gopls` language server with `go install
  golang.org/x/tools/gopls@latest`
+ Add the go binary to the `PATH` and to the list of executables
  `exec-path`
+ Setup hooks as explained
  [here](https://github.com/golang/tools/blob/master/gopls/doc/emacs.md)
  
### Python

+ Install `direnv` to your host
+ Add an `.envrc` to your project to use a python layout
+ Open a `.py` file; `lsp-pyright` automatically installs the language
  server if not available (this is currently done via Node.js)
+ Look [here](https://github.com/purcell/envrc) if you need to work
  with multiple virtual environments at the same time
  
### Rust

+ Install `rust-analyzer` or `rls`
+ You can use `rustfmt` as formatter

### Javascript and Typescript

+ Install the `Deno` runtime (see [here](https://deno.land/#installation))
+ `Deno` already ships with a language server, a linter, and a
  formatter
+ Use a `tsconfig.json` to enable additional options

### LaTeX

I actually don't use LSP to work with LaTeX, as
[AUCTeX](https://www.gnu.org/software/auctex/) works smoothly (though
`company` completion is not particularly responsive). When you work on
a complex document split across many source files, you can use
variables to set up the environment (see
[here](https://www.gnu.org/software/auctex/manual/auctex.html#Multifile)).
This will allow you to run `TeX-command-master` and `TeX-view` from
any of the source files. Also, company will be able to fetch the bib
entries properly.
