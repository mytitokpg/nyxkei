import sys
import os

def main():
    project_name = os.path.basename(os.getcwd())
    print(f"🚀 Running project: {project_name}")
    print(f"🐍 Python: {sys.version.split()[0]}")
    
    venv_path = os.environ.get("VIRTUAL_ENV")
    if venv_path:
        print(f"🛠️ Virtual env: {venv_path}")
    else:
        print("⚠️ No virtual environment detected. Run 3_nyxkei_VE.bat first.")
    
    # Example: check for an extra dependency
    try:
        import requests
        print(f"🌐 requests v{requests.__version__} is available")
    except ImportError:
        print("ℹ️ requests not installed. Use 2_Install_Packages.bat to add it, if needed.")

    # Your project logic goes here
    print("✅ example_project.py executed successfully!")

    # --- nyxkei tool info ---
    print("\n🔧 nyxkei setup is complete! Here’s what to do next:")
    print("  • Run 1_Start.bat to launch your app inside the venv.")
    print("  • Run 2_Install_Packages.bat to install any missing packages.")
    print("  • If you mess up, delete the venv folder (named after your project),")
    print("    as well as the 1_Start.bat and 2_Install_Packages.bat files,")
    print("    then re-run 3_nyxkei_VE.bat to rebuild/reset your environment.")
    print("    Remember to run: pip freeze > requirements.txt")
    print("    inside your activated venv to save any newly installed packages.")

if __name__ == "__main__":
    main()
