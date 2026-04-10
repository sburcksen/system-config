{ lib, ... }:

{
  mkSubOption =
    default: description:
    lib.mkOption {
      type = lib.types.bool;
      inherit default;
      description = "Enables " + description;
    };
}
