{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    (pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
  ];

  packages = with pkgs; [
    neovim
    starship
    # (python3.withPackages (python-pkgs: [
    #   python-pkgs.ansible-core
    #   python-pkgs.requests
    #   python-pkgs.google-auth
    #   python-pkgs.google-cloud-storage
    # ]))
  ];
}
