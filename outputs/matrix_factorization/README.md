# Matrix Factorization Outputs

This folder contains outputs of the [matrix factorization notebook](../../notebooks/7. Matrix Factorization.ipynb). See the notebook for the details.

## Interim Datasets

- [98_test_construct_prob_scaled.csv](98_test_construct_prob_scaled.csv): jaccard_coefficient matrix of co-appearance of tests and constructs. Values are log-transformed, see the dataset below for the raw matrix.
- [99_test_construct_prob.csv](99_test_construct_prob.csv): jaccard_coefficient matrix of co-appearance of tests and constructs (matrix `X`). Values are raw probabilities between 0 and 1.
- [3_tests_embedding.csv](3_test_embedding.csv): contains embedding matrix for the cognitive tests (matrix `M`). See the corresponding png for a clustered heat map.
- [4_constructs_embedding.csv](4_constructs_embedding.csv): embedding matrix for the cognitive constructs (matrix `C`). See the corresponding png for a clustered heat map.

**Note:** Embeddings are extracted from the jaccard_coefficient matrix using non-negative matrix factorization. No constraint such as probabilistic values or logit transformation was assumed.
