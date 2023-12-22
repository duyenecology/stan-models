library(targets)
library(tarchetypes)
library(quarto)
library(tidyverse)
library(stantargets)
library(cmdstanr)
library(furrr)
library(bayesplot)

source("R/functions.R")

# parallel computing on local or on the same node
plan(multicore)
options(clustermq.scheduler = "multicore")

tar_option_set(packages = c(
  "tidyverse",
  "bayesplot",
  "ggrepel",
  "patchwork",
  "janitor",
  "loo"
))

# keep memory usage down to a minimum
tar_option_set(
  garbage_collection = TRUE,
  memory = "transient"
)

# check if it's inside a container
if (file.exists("/.dockerenv") | file.exists("/.singularity.d/startscript")) {
  Sys.setenv(CMDSTAN = "/opt/cmdstan/cmdstan-2.29.2")
  set_cmdstan_path("/opt/cmdstan/cmdstan-2.29.2")
}

cmdstan_version()

list(
  # eight schools
  tar_target(
    schools_data,
    list(
      J = 8,
      y = c(28, 8, -3, 7, -1, 1, 18, 12),
      sigma = c(15, 10, 16, 11, 9, 11, 10, 18))
  ),
  # # fit a single stan model
  # tar_stan_mcmc(
  #   fit,
  #   "stan/eight_schools.stan",
  #   data = schools_data,
  #   refresh = 0,
  #   chains = 4,
  #   parallel_chains = getOption("mc.cores", 4),
  #   iter_warmup = 2000,
  #   iter_sampling = 2000,
  #   adapt_delta = 0.95,
  #   max_treedepth = 15,
  #   seed = 123,
  #   return_draws = TRUE,
  #   return_diagnostics = TRUE,
  #   return_summary = TRUE,
  #   summaries = list(
  #     mean = ~mean(.x),
  #     sd = ~sd(.x),
  #     mad = ~mad(.x),
  #     ~posterior::quantile2(.x, probs = c(0.025, 0.05, 0.25, 0.5, 0.75, 0.95, 0.975)),
  #     posterior::default_convergence_measures()
  #   )
  # ),
  # fit a single stan model
  tar_target(
    lm_data, {
      n <- 100
      x <- rnorm(n)
      y <- rnorm(n, 2 * x - 1, 0.6)
      list(N = n, x = x, y = y)
    }
  ),
  tar_stan_mcmc(
    fit,
    "stan/lm.stan",
    data = lm_data,
    refresh = 0,
    chains = 4,
    parallel_chains = getOption("mc.cores", 4),
    iter_warmup = 1000,
    iter_sampling = 1000,
    adapt_delta = 0.95,
    max_treedepth = 15,
    seed = 123,
    return_draws = TRUE,
    return_diagnostics = TRUE,
    return_summary = TRUE,
    summaries = list(
      mean = ~mean(.x),
      sd = ~sd(.x),
      mad = ~mad(.x),
      ~posterior::quantile2(.x, probs = c(0.025, 0.05, 0.25, 0.5, 0.75, 0.95, 0.975)),
      posterior::default_convergence_measures()
    )
  ),
  tar_quarto(
    regressions_html,
    "docs/regressions.qmd"
  ),
  # putting NULL makes easy to remove tar_target from this list
  NULL
)
