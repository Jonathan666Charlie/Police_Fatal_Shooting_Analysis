# Fit Poisson regression model
poisson_model <- glm(killings ~ median_income + poverty_rate + unemployment_rate +
                       college_graduates + state_affiliation +
                       armed_mode + cause_mode,
                     data = county_data,
                     family = poisson)

# Display regression summary
summary(poisson_model)

