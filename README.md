[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

# Stan examples for regression models

This repository contains examples demonstrating the use of Stan for regression modeling, with a focus on efficiency and reproducibility in data analysis workflows.

## Requirements for running this demo

- [R (>= 4.0.0)](https://cran.rstudio.com/)
- [Quarto](https://quarto.org/): An open-source scientific and technical publishing system built on Pandoc
- [cmdstan](https://mc-stan.org/users/interfaces/cmdstan): The shell interface to Stan
- [`renv`](https://rstudio.github.io/renv/): A dependency management toolkit for R.
This will install the key packages including:
	- `targets`
	- `stantargets`
	- `tachetypes`
	- `cmdstanr`,
	- `TinyTex`

## Usage

### Restoring packages

The following R command reinstall packages recorded in the `renv.lock` file.

```{r}
r$ |> renv::restore()
```

### Running code on local

```{bash}
> run.sh
1) tar_make() on local
2) tar_make_clustermq() on local
Enter number：
```

1. Run tar_make() locally for standard processing.
1. Use tar_make_clustermq() locally for parallel processing.


### Exercises

Engage with hands-on exercises provided in `docs/regression.qmd(html)`.
These exercises are designed to enhance your understanding of regression modeling in Stan, with a focus on vectorization and reparameterization techniques and the use of `targets` and `stantargets` for efficient and reproducible workflows.
