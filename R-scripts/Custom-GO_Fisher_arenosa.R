  # Define a function to perform Fisher's Exact Test and return results
  perform_fisher_test <- function(a, b, c, d) {
    # Create the contingency table
    contingency_table <- matrix(c(a, b, c, d), nrow = 2, byrow = TRUE, 
                                dimnames = list(c("PEGs", "non-PEGs"), 
                                                c("Pathway", "Non-Pathway")))
    
    # Perform Fisher's Exact Test
    fisher_test_result <- fisher.test(contingency_table)
   
    
    # Return odds ratio and p-value
    return(c(odds_ratio = fisher_test_result$estimate, p_value = fisher_test_result$p.value))
  }
  
  # Sample data for five sets (eg. number of PEGs, non-PEGs, not in list, and not pathway)
  data_sets <- list(
    "F-box-protein_PEGs" = c(19, 52, 1302, 32420),
    "ubiquitin protein transferase_PEGs" = c(15, 56, 742, 32980),
    "ubiquitin protein ligase_PEGs" = c(11, 60, 461, 33261),
    "F-box-protein_MEGs" = c(7, 498, 1314, 31974),
    "COP9 signalosome_MEGs" = c(5, 500, 6, 33282)
  )
  
  # Initialize a dataframe to store results
  results <- data.frame(Set = character(), Odds_Ratio = numeric(), P_Value = numeric(), stringsAsFactors = FALSE)
  
  # Loop through each dataset and perform Fisher's exact test
  for (set_name in names(data_sets)) {
    values <- data_sets[[set_name]]
    odds_p_values <- perform_fisher_test(values[1], values[2], values[3], values[4])
    
    # Append results to the dataframe
    results <- rbind(results, data.frame(Set = set_name, Odds_Ratio = odds_p_values[1], P_Value = odds_p_values[2]))
  }
  
  # Print results
  print(results)
  
  # Load the required library
  library(ggplot2)
  
  # Define custom order for the sets if desireable
  custom_order <- c("ubiquitin protein transferase_PEGs", "ubiquitin protein ligase_PEGs", "F-box-protein_PEGs", "COP9 signalosome_MEGs", "F-box-protein_MEGs")
  
  # Convert the "Set" column to a factor with the specified order
  
results$Set <- factor(results$Set, levels = custom_order)
  
  # Create the bar plot for Odds Ratios _ with Odds ratios on y-axis- Log2- 
  
  ggplot(results, aes(x = log2(Odds_Ratio), y = Set, fill = P_Value)) +
    geom_bar(stat = "identity") +
    coord_flip() +  # Flip the coordinates for better readability
    scale_fill_gradient(low = "salmon", high = "royalblue", name = "P-value") +  # Gradient color scale
    labs(title = "Custom-enrichment_arenosa",
         x = "log2-Odds Ratio",
         y = "Set") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Tilt y-axis labels

  