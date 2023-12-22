[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

# Stan examples for regression models

This repository contains examples demonstrating the use of Stan for regression modeling, with a focus on efficiency and reproducibility in data analysis workflows.

## Requirements for running this demo

- [R (>= 4.0.0)](https://cran.rstudio.com/)
- [Quarto](https://quarto.org/): An open-source scientific and technical publishing system built on Pandoc
- [cmdstan](https://mc-stan.org/users/interfaces/cmdstan): The shell interface to Stanj
- [`renv`](https://rstudio.github.io/renv/): A dependency management toolkit for R.
This will install the key packages, including:
`targets`,
`stantargets`,
`tachetypes`,
`cmdstanr`,
`tinytex`,
and ensure the installation of `cmdstan` and `TinyTex`.

## Usage

### Forking the Repository and Creating a New Branch

To interact with this repository:

1. Fork the Repository:
	- Go to the original repository on GitHub.
	- Click the "Fork" button to create your copy.

2. Clone Your Fork:
	- Clone it to your machine: git clone [URL of your fork].

3. Create a New Branch:
	- Inside the cloned directory: git checkout -b [new_branch_name].

4. Stay Updated:
	- Set the original repository as "upstream" and regularly pull updates.

Benefits of Forking:

- Personal Exploration: Freely experiment with the code without affecting the main repository.

- Version Control: Practice using Git, a crucial skill in complex data analysis.

- Ongoing Updates: Easily merge updates from the main repository into your fork.


### Restoring packages

Reinstall packages from `renv.lock`:

```{r}
r$ |> renv::restore()
```

### Running code on local

Execute using the provided script (`run.sh`):

```{bash}
> run.sh
1) tar_make() on local
2) tar_make_clustermq() on local
Enter number：
```

1. Run tar_make() locally for standard processing.
1. Use tar_make_clustermq() locally for parallel processing.


### Exercises

Try exercises in `docs/regression.qmd` or `docs/regression.html`.
These exercises focus on vectorization, reparameterization, and using `targets` and `stantargets` for efficient, reproducible workflows.
