# Phase 00 · Checkpoint 01 — Dev Environment Setup

Personal walkthrough of the AI Engineering From Scratch curriculum. This phase covers toolchain verification, an isolated Python environment, dependency declaration, locking, and reproducibility.

## Table of Contents

- [Learning Objectives](#learning-objectives)
- [Checkpoint 1: Toolchain Execution Verification](#checkpoint-1-toolchain-execution-verification)
  - [Commands to Run for System Audit and Toolchain Verification](#commands-to-run-for-system-audit-and-toolchain-verification)
    - [Make the Scripts Executable](#make-the-scripts-executable)
    - [Run the Executables to Validate Script Checks](#run-the-executables-to-validate-script-checks)
    - [Or simply run the script files using bash like so without doing the 2-steps above](#or-simply-run-the-script-files-using-bash-like-so-without-doing-the-2-steps-above)
- [Checkpoint 2: Create an isolated Python environment](#checkpoint-2-create-an-isolated-python-environment)
  - [Step 1 — Initialize your Python project](#step-1--initialize-your-python-project)
  - [Step 2 — Create the virtual environment](#step-2--create-the-virtual-environment)
  - [Checkpoint 2.1 — Virtual Environment Created and Verified ✅](#checkpoint-21--virtual-environment-created-and-verified-)
    - [What have you learned?](#what-have-you-learned)
  - [Checkpoint 2.2 — Add a Dependency and Generate a Lockfile](#checkpoint-22--add-a-dependency-and-generate-a-lockfile)
    - [Step 1 — Add NumPy](#step-1--add-numpy)
    - [Step 2 — Verify the configuration](#step-2--verify-the-configuration)
    - [Step 3 — Test NumPy](#step-3--test-numpy)
  - [What we're establishing](#what-were-establishing)
  - [Checkpoint 2.2 — Dependency Management Verified ✅](#checkpoint-22--dependency-management-verified-)
    - [What you've achieved](#what-youve-achieved)
  - [Checkpoint 2.3 — Verify Reproducibility](#checkpoint-23--verify-reproducibility)
    - [What have we achieved?](#what-have-we-achieved)
  - [Next: Learning Objective 3](#next-learning-objective-3)
  - [Completion Criteria](#completion-criteria)

## Learning Objectives

- [ ] Set up Python 3.11+, Node.js 20+, and Rust toolchains from scratch
- [ ] Configure virtual environments and package managers for reproducible builds
- [ ] Verify GPU access with CUDA/MPS and run a test tensor operation
- [ ] Understand the four-layer stack: system, packages, runtimes, AI libraries

---

## Checkpoint 1: Toolchain Execution Verification.

> [!TIP]
> This one of the learning objectives that you need to verify before moving to the next steps. Make sure that you complete these steps as it's very straight forward and simply following the ready-to-run script commands in this repo to verify if your existing system and toolchain has the prerequisites in an automated fashion.

### Commands to Run for System Audit and Toolchain Verification

> [!NOTE]
> Make sure you are in the right repository `~/workspace/ai-engineering`.

#### Make the Scripts Executable

```zsh
chmod +x phases/00-setup-and-tooling/01-dev-environment/scripts/test-toolchains.sh
```

#### Run the Executables to Validate Script Checks

```zsh
phases/00-setup-and-tooling/01-dev-environment/scripts/test-toolchains.sh
```

#### Or simply run the script files using `bash` like so without doing the 2-steps above

```zsh
bash phases/00-setup-and-tooling/01-dev-environment/scripts/test-toolchains.sh
```

If you were able to get successfull responses with the *toolchain verification*, that means you've completed to **Set up Python 3.11+, Node.js 20+, and Rust toolchains from scratch**

If the verification scripts fail because Python, Node.js, or Rust is not installed, install the missing toolchain before running the scripts again.

- Python: Install Python 3.11 or later using the official [Python website](https://python.org/downloads/) or a version manager such as pyenv.
- Node.js: Install Node.js 20 or later from the official [Node.js](https://nodejs.org/en/download) website.
- Rust: Install Rust and Cargo using the official [Rust](https://rust-lang.org/tools/install/) installation guide.
- Homebrew (macOS): Install it from the official [Homebrew](https://brew.sh/) website if you want to use it to manage development tools.

After installation, restart your terminal if necessary and rerun the verification scripts.

> [!IMPORTANT]
> Install only the tools that are missing. If a tool is already installed but the script cannot find it, check your PATH configuration before reinstalling it.

---

## Checkpoint 2: Create an isolated Python environment.

**What we're going to accomplish**

By the end of this objective, you'll be able to:

1. Create an isolated Python virtual environment.
2. Manage project dependencies using uv.
3. Understand the roles of uv, pip, pyproject.toml, and uv.lock.
4. Reproduce the environment from its dependency configuration.
5. Verify that your project works independently of your global Python packages.

Our target structure

```text
01-dev-environment/
├── README.md
├── pyproject.toml
├── uv.lock
├── .venv/
└── scripts/
    └── test-toolchains.sh
```

We'll create these as we need them. The `.venv/` directory should remain local to your machine and should not be committed to Git.

### Step 1 — Initialize your Python project

First, navigate to the project directory from your repository root:

`cd phases/00-setup-and-tooling/01-dev-environment`

Confirm that you're in the right place:

```zsh
pwd
ls -la
```

Now initialize the project with your existing Python 3.14 installation:

`uv init --bare --python 3.14`

Why this command?

- uv init initializes a Python project.
- --bare creates a minimal project configuration without the extra starter files.
- --python 3.14 selects Python 3.14 for the project.

We're not downgrading Python because we haven't encountered a compatibility issue that justifies doing so.

### Step 2 — Create the virtual environment

Run this command from your current 01-dev-environment directory:

`uv venv`

By default, uv should create a .venv directory inside your project.

You should see output indicating that the virtual environment was created, typically using your installed Python 3.14 interpreter.

Verify that it exists

Run:

```zsh
ls -la .venv
```

Then check which Python interpreter the environment uses:

`.venv/bin/python --version`

Finally, verify the interpreter's location:

`.venv/bin/python -c "import sys; print(sys.executable)"`

The executable path should point inside your project's .venv directory.

**What have we achieved if these tests pass?**

You'll have an isolated Python environment associated with your project.

That means you can install project-specific packages without automatically installing them into your global Python environment.

> [!IMPORTANT]
> Creating a virtual environment doesn't automatically make dependencies reproducible. We'll address dependency declarations and locking in the next checkpoint.

---

### Checkpoint 2.1 — Virtual Environment Created and Verified ✅

Excellent. All three checks confirm that your virtual environment was created successfully.

| Verification | Your result | Status |
| :--- | :--- | :--- |
| **Virtual environment creation** | `.venv` created using CPython 3.14.0 | **PASS** |
| **Python version** | Python 3.14.0 | **PASS** |
| **Interpreter location** | Inside your project's `.venv/bin/` directory | **PASS** |

The most important result is this path:

`/Users/frankuccino/dev/learning/ai-engineering/phases/00-setup-and-tooling/01-dev-environment/.venv/bin/python`

It confirms that you're running the project-specific Python interpreter, rather than directly invoking the global interpreter at `/Users/frankuccino/.pyenv/versions/3.14.0/bin/python3`.

#### What have you learned?

A virtual environment provides a separate location for a project's Python packages and executables.

Your global Python installation remains available, while this project has its own environment. This helps prevent dependencies from different projects from interfering with one another.

> [!NOTE]
> One subtle point — the virtual environment uses your existing Python installation as its base. It doesn't install an entirely independent copy of Python.

---

### Checkpoint 2.2 — Add a Dependency and Generate a Lockfile

Now we'll make your environment useful by adding a real Python package.

We'll use **NumPy**, a library for numerical computing that will also be useful when we explore AI libraries later.

#### Step 1 — Add NumPy

Make sure you're still in:

```zsh
ai-engineering/phases/00-setup-and-tooling/01-dev-environment/
```

Run: `uv add numpy`

**What should this do?**

1. Resolve a NumPy version compatible with your Python requirement.
2. Install NumPy into your project's virtual environment.
3. Add NumPy to pyproject.toml.
4. Generate or update uv.lock with the resolved dependency information.

This is the key difference between manually installing a package and managing it as a project dependency: **the dependency becomes part of your project's configuration.**

#### Step 2 — Verify the configuration

Inspect your project configuration:

```zsh
cat pyproject.toml
```

You should now see NumPy listed under `dependencies`.

Then inspect the lockfile:

```zsh
ls -l uv.lock
```

The lockfile should exist if dependency resolution succeeded. Represented as `uv.lock`

#### Step 3 — Test NumPy

```zsh
uv run python -c "import numpy; print('NumPy version:', numpy.__version__); print(numpy.array([1, 2, 3]) * 2)"
```

Expected output will resemble:

```text
NumPy version: <installed version>
[2 4 6]
```

The exact version may differ.

This tests two things: that NumPy can be imported and that it can perform a basic numerical operation.

## What we're establishing

| Component | Responsibility |
| :--- | :--- |
| `pyproject.toml` | Declares the project's dependencies and requirements. |
| `uv.lock` | Records the resolved dependency versions. |
| `.venv/` | Contains the project's isolated environment. |
| `uv` | Manages dependency resolution, installation, and project execution. |
| `NumPy` | Provides numerical computing functionality. |

We'll discuss `pip` and how it differs from `uv` after verifying this step.

**The task you should have completed:** Run `uv add numpy`, inspect `pyproject.toml` and `uv.lock`, and execute the NumPy test.

### Checkpoint 2.2 — Dependency Management Verified ✅

Your results look good. All three checks passed.

| Check | Evidence | Status |
| :--- | :--- | :--- |
| **Dependency declaration** | `numpy>=2.5.4` in `pyproject.toml` | ✅ **PASS** |
| **Lockfile generated** | `uv.lock` exists and records NumPy 2.5.4 | ✅ **PASS** |
| **Package execution** | NumPy imports and calculates `[1, 2, 3] * 2` as `[2, 4, 6]` | ✅ **PASS** |

#### What you've achieved

Your project now has three distinct pieces:

- `pyproject.toml` declares that your project depends on NumPy version 2.5.4 or newer.
- `uv.lock` records the resolved NumPy version, 2.5.4, along with package metadata, hashes, and compatible distribution options.
- `.venv/` contains the isolated environment in which NumPy is installed and runs.

### Checkpoint 2.3 — Verify Reproducibility

Now let's test whether uv can synchronize your environment with the dependency versions recorded in uv.lock.

From your `01-dev-environment` directory, run:

```zsh
uv sync --locked
```

**What does this command do?**

- `uv sync` synchronizes your virtual environment with your project's dependencies.
- `--locked` requires the existing lockfile to be up to date with pyproject.toml. It will fail rather than silently update an outdated lockfile.

If it succeeds, verify NumPy again:

```zsh
uv run --locked python -c "import numpy; print('NumPy:', numpy.__version__); print(numpy.array([1, 2, 3]) * 2)"
```

Expected output:

```text
NumPy: 2.5.4
[2 4 6]
```

You should see NumPy version 2.5.4 and the result [2 4 6].

**What this proves**: Your project configuration and lockfile are consistent, and the environment can be synchronized against the locked dependency resolution. It is a useful reproducibility check, though it doesn't by itself prove that a completely fresh machine can recreate the environment.

#### What have we achieved?

| Checkpoint | Result | Evidence |
| :--- | :--- | :--- |
| Initialize Python project | ✅ PASS | pyproject.toml created |
| Create virtual environment | ✅ PASS | .venv/bin/python uses Python 3.14.0 |
| Manage dependencies | ✅ PASS | NumPy declared in pyproject.toml |
| Generate lockfile | ✅ PASS | uv.lock records NumPy 2.5.4 |
| Synchronize environment | ✅ PASS | uv sync --locked succeeded |
| Verify package execution | ✅ PASS | NumPy returned [2 4 6] |

Learning Objective 2 is complete at the level of the requirements we've practiced.

You have not yet tested recreating the environment from scratch, but you've verified dependency declaration, locking, synchronization, and execution.

---

### Next: Learning Objective 3

Your next objective is:

Verify GPU access with CUDA/MPS and run a test tensor operation.

---

### Completion Criteria

This phase is complete when all four learning objectives have been addressed, the relevant tests pass, and I can explain the purpose of the tools and configuration rather than simply reproduce the commands.
