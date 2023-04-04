{...}:

{
  programs.git = {
    enable = true;
    userName = "Max Hallinan";
    userEmail = "maxhallinan@gmail.com";
    ignores = [
      # Based on https://gist.github.com/octocat/9257657

      # Compiled source #
      ###################
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Packages #
      ############
      # it's better to unpack these files and commit the raw source
      # git has its own built in compression methods
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "node_modules"

      # Logs and databases #
      ######################
      "*.log"
      "#*.sql"
      "*.sqlite"

      # OS generated files #
      ######################
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      "*.swp"
      "*.swo"

      # Byte-compiled / optimized / DLL files
      "__pycache__/"
      "*.py[cod]"
      "*$py.class"

      # # C extensions
      "*.so"

      # Distribution / packaging
      ".Python"
      "env/"
      "build/"
      "develop-eggs/"
      "dist/"
      "downloads/"
      "eggs/"
      ".eggs/"
      "lib64/"
      "parts/"
      "sdist/"
      "var/"
      "*.egg-info/"
      ".installed.cfg"
      "*.egg"

      # PyInstaller
      #  Usually these files are written by a python script from a template
      #  before PyInstaller builds the exe, so as to inject date/other infos into it.
      "*.manifest"
      "*.spec"

      # Installer logs
      "pip-log.txt"
      "pip-delete-this-directory.txt"

      # Unit test / coverage reports
      "htmlcov/"
      ".tox/"
      ".coverage"
      ".coverage.*"
      ".cache"
      "nosetests.xml"
      "coverage.xml"
      "*,cover"
      ".hypothesis/"

      # Translations
      "*.mo"
      "*.pot"

      # Django stuff:
      "*.log"
      "local_settings.py"

      # Flask stuff:
      "instance/"
      ".webassets-cache"

      # Scrapy stuff:
      ".scrapy"

      # Sphinx documentation
      "docs/_build/"

      # PyBuilder
      "target/"

      # IPython Notebook
      ".ipynb_checkpoints"

      # pyenv
      ".python-version"

      # celery beat schedule file
      "celerybeat-schedule"

      # dotenv
      ".env"

      # virtualenv
      "venv/"
      "ENV/"
      "include/"
      "lib/"

      # pip
      "pip-selfcheck.json"

      # Spyder project settings
      ".spyderproject"

      # Rope project settings
      ".ropeproject"

      # Yoeman generator settings
      ".yo-rc.json"

      # Elm
      "elm-stuff"

      "nix"

      ".s3cfg"
    ];
  };
}
