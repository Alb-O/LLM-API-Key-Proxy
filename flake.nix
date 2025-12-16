{
  description = "LLM API Key Proxy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          python3
          python3Packages.pip
          stdenv.cc.cc.lib
        ];
        
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        
        shellHook = ''
          # Create venv if it doesn't exist
          if [ ! -d "venv" ]; then
            echo "Creating virtual environment..."
            python3 -m venv venv
          fi
          
          # Activate venv
          source venv/bin/activate
          
          # Install dependencies if needed
          if [ ! -f "venv/.installed" ]; then
            echo "Installing dependencies..."
            pip install -r requirements.txt
            touch venv/.installed
          fi
          
          # Add src to PYTHONPATH so rotator_library can be imported
          export PYTHONPATH="$PWD/src:$PYTHONPATH"
          
          echo "Environment ready!"
          echo ""
          echo "Available commands:"
          echo "  python src/proxy_app/main.py    - Run the proxy"
          echo "  python -m rotator_library       - Manage credentials (interactive TUI)"
          echo ""
          echo "Or use the wrapper scripts: ./run.sh or ./credential-tool.sh"
        '';
      };
    };
}
