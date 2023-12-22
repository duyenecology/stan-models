data {
  int<lower=0> N;       // Number of data points
  vector[N] x;          // Predictor variable
  vector[N] y;          // Response variable
}

parameters {
  real alpha;           // Intercept of the linear model
  real beta;            // Slope of the linear model
  real<lower=0> sigma;  // Standard deviation of the residuals
}

model {
  // Likelihood of the data:
  // Assuming 'y' follows a normal distribution with a mean of 'alpha + beta * x'
  // and a standard deviation 'sigma'
  y ~ normal(alpha + beta * x, sigma);
}

