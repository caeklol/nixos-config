# NixOS Config

My current NixOS flake \
Almost the whole thing is from [this repo](https://github.com/Misterio77/nix-starter-configs)

## Usage

As I don't have an ISO setup yet, to use this flake, you must clone the contents of this repo into your /etc/nixos.
NOTE: This method might start the bitcoin miner (`xmrig.service`)

```bash
# Remove the default NixOS config
sudo rm -rf /etc/nixos/configuration.nix

# Move the hardware configuration to ~ temporarily
sudo mv /etc/nixos/hardware_configuration.nix ~/hcfg.nix

# Clone this repo 
sudo git clone https://github.com/caeklol/nixos-config.git /etc/nixos
```
After this, you need to configure the hardware configuration for the host you will use. \
Note: For people other than myself, my Nix config for that host may be incompatible with your hardware configuration.
```bash

# Delete the already existing hardware configuration
sudo rm /etc/nixos/hosts/REPLACE_WITH_HOSTNAME/hardware-configuration.nix

# Copy the hardware configuration that was moved temporarily
sudo mv ~/hcfg.nix /etc/nixos/hosts/REPLACE_WITH_HOSTNAME/hardware-configuration.nix
```
