clear; clc; close all; format compact;

filename = 'data/chess-KingRookVKingPawn.arff.txt';
[train_data, meta] = read_arff_file(filename);

y = train_data(:, end);
unique_y = meta.attribute_values{end};
n_folds = 10;
[indices_set] = generate_cross_validation_data(y, unique_y, n_folds);
[n_correct_naive, n_correct_TAN, n_test_size] = train_and_test_w_cross_validation(train_data, meta, indices_set);

%%
saved_n_correct_naive = [277,274,287,284,274,275,278,275,280,299];
saved_n_correct_TAN   = [283,294,291,304,294,288,296,293,301,316];
saved_n_test_size     = [318,318,318,318,318,318,318,318,318,334];

percent_correct_naive = saved_n_correct_naive./saved_n_test_size;
percent_correct_TAN   = saved_n_correct_TAN  ./saved_n_test_size;

mean(percent_correct_naive)
mean(percent_correct_TAN)

[h, p, ci, stats] = ttest(percent_correct_naive, percent_correct_TAN);