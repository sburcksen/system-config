# system-configuration
My system configuration using NixOs, Home-Manager and some regular dotfiles.

The following hosts are configured:
- PC
- Laptop
- NAS

It is possible to also exculsively use home-manager on a non NixOS system.

### Repository

- [**hosts/**](hosts/)
  All configured NixOS hosts containing machine specific configuration.

- [**modules/**](modules/)
  Shared NixOS modules used by the hosts.
  - [**modules/common**](modules/common)
  - [**modules/desktop**](modules/desktop)
  - [**modules/server**](modules/server)

- [**dotfiles/**](dotfiles/)
  Regular dotfiles used by Home Manager.

- [**home-manager/**](home-manager/)
  Custom Home Manager modules. Home Manager options are integrated into NixOS modules via the `home` option.

