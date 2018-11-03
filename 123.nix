boot.kernelPackages  = pkgs.linuxPackages_custom {
    version = "4.4.0-rc5";
    src = pkgs.fetchurl {
      url =
"mirror://kernel/linux/kernel/v4.x/testing/linux-4.4-rc5.tar.xz";
      sha256 = "0qr1a8nmq6csbsw4cbqnn3m37a0fapj7a7cm9vj7fy7kq1rgxkpb";
    };
    configfile = /etc/nixos/kernel-4.4.0-rc5/kernel-4.4.0-rc5.config;
  };

ran *nixos-rebuild switch* and got a shiny new kernel. Based on the same
wiki page, I then added the following to my configuration.nix file hoping
to apply kernel patches to the new kernel.

 nixpkgs.config = {
   packageOverrides = pkgs: {
     stdenv = pkgs.stdenv // {
       platform = pkgs.stdenv.platform // {
         kernelPatches = [
  { patch=/etc/nixos/kernel-4.4.0-rc5/01_check_fwnode_type.patch;
name="yoga900_01"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/02_rename_is.to_pset.patch;
name="yoga900_02"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/03_refactor_builtin_prop.patch;
name="yoga900_03"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/04_keep_single_value.patch;
name="yoga900_04"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/05_helper_macro_prop.patch;
name="yoga900_05"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/06_improve_readability.patch;
name="yoga900_06"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/07_prop_not_found_ret_EINVAL.patch;
name="yoga900_07"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/08_fallback-2_sec_fwnode.patch;
name="yoga900_08"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/09_take_copy_prop_set.patch;
name="yoga900_09"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/10_supp_builtin_prop.patch;
name="yoga900_10"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/11_dont_overwrite_sce_fwnode.patch;
name="yoga900_11"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/12_propagate_dev_prop_2_sub.patch;
name="yoga900_12"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/13_pass_dev_params_supp.patch;
name="yoga900_13"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/14_pass_sda_hold_time.patch;
name="yoga900_14"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/15_pass_uart_conf.patch;
name="yoga900_16"; }
  { patch=/etc/nixos/kernel-4.4.0-rc5/16_convert_unified_dev_prop.patch;
name="yoga900_16"; }
         ];
       };
     };
   };
  };
