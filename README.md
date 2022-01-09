# dot-emacs

My minimal `.emacs.d` files. Target: Debian/Ubuntu.

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
directory in a new Emacs frame, I simply type `ef $(PATH_NAME)` to
call _emacsclient_ (`et` when I want to stay in the terminal). In case
I need to update my configuration there are two alternatives:
+ if it's just something I want to tweak right on the spot, I open a
  new buffer, type some Elisp and then call `eval-region`. This are
  modifications that do not persist with a restart of the daemon;
+ if it's something more complex, I edit and save the dotfiles, close
  the client, and then restart the daemon running on the `kill-emacs;
  start-emacs` commands.
  
### Bash functions and aliases

```bash
# emacsclient functions
et () { emacsclient -nw "$@"; }
ef () { emacsclient -c "$@" & disown; }

# start emacs daemon
alias start-emacs='emacs --daemon'

# kill emacs alias
alias kill-emacs='emacsclient -e "(kill-emacs)"'
```
  
## Misc

This pragmatic use of Emacs has some pros and cons, but I found it
very productive. In the following there's list of considerations and
remarks that might be useful.

+ Why using a daemon and not separate Emacs instances? Packages are
  loaded only once, subsequent frame openings occur instantaneously.

+ Why `use-package`? It easy to use, and it permits to keep the
  dotfiles tidy and readable. There are powerful alternatives as
  `straight.el`, but I don't feel the need to use a package manager
  yet.

+ Why the first boot is so slow? The first time `init.el` is loaded,
  all the packages are downloaded, compiled and loaded. 

+ Do you only use packages from melpa and melpa-stable? Basically
  yes. When I work on a fresh machine the setup boils down to creating
  a link to my dotfiles and then running the command `start-emacs`.
  
+ Why Regolith? No initial setup cost, and when you need something
  more complex, you can directly edit the i3 configuration. I no
  longer have the same integration I had with EXWM, but in case of
  problem, I can just kill and restart the server instead of the whole
  X session.
  
+ Why `package-native-compile`? Code development inside a VM with
  `lsp` is a bit laggy, and not particularly responsive. Compiling and
  installing Emacs with native compilation support significantly
  improves the experience. If native compilation is available,
  `package-native-compile` tells the built-in package manager to
  perform native compilation when installing a package.
  
+ Only Python, Go and Rust? These are the languages I use when I start
  a project from scratch. With huge codebases (like the AOSP), I use
  Emacs to edit and search for files, but I don't use it to perform
  any indexing. On the other hand, when projects are too small, I just
  rely on the built-in capabilities to highlight the syntax. Also
  notice that I tend to rely only on lsp basic functions. In general,
  I think that language-specific command line tools are more
  convenient when there is the need to test, debug and profile (and
  they can be neatly arranged into Makefile recipes).

+ Some commands/keybindings do not work. Yes, there are Emacs packages
  that rely on binaries that need to be available on the host. In
  these cases, I just make sure the package or function does not cause
  installation errors (on a fresh host environment). 

+ Any updates? I plan to update this public version of the dotfiles
  from time to time. I'm always testing new packages, but I keep them
  only if they are really useful (the more I use Emacs the more I'm
  impressed by the things you can do with it).
  
+ Some keybindings seem unnatural. That's because I use an [Ergodox
EZ](https://ergodox-ez.com/) with a custom layout. It allows me to
write code without ever moving my wrists.
