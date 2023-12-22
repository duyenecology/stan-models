data {
  int<lower=0> J; // Number of data points
  vector[J] y; // Response variable
  vector<lower=0>[J] sigma; // Std deviation of measurement errors
}

parameters {
  real mu; // Mean parameter of the model
  real<lower=0,upper=pi()/2> tau_unif; // Uniform prior for tau (0 to pi/2)
  array[J] real theta_tilde; // Standardized effect sizes
}

transformed parameters {
  real<lower=0> tau; // Scale parameter for effects
  array[J] real theta; // Actual effect sizes
  tau = 5 * tan(tau_unif); // Transform tau_unif to half-Cauchy for tau
  for (j in 1:J)
    theta[j] = mu + tau * theta_tilde[j]; // Scale & shift standardized effects
}

model {
  mu ~ normal(0, 5); // Prior for mean parameter
  theta_tilde ~ std_normal(); // Prior for standardized effects
  y ~ normal(theta, sigma); // Likelihood of the data
}

generated quantities {
  vector[J] log_lik; // Log-likelihood for each observation
  for (j in 1:J)
    log_lik[j] = normal_lpdf(y[j] | theta[j], sigma[j]); // Calc log-likelihood
}
