# src/rotator_library/__main__.py
"""Entry point for running rotator_library.credential_tool as a module."""

if __name__ == "__main__":
    from .credential_tool import run_credential_tool
    run_credential_tool(from_launcher=False)
