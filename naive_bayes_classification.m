function [test_label_pred, probability] = naive_bayes_classification(train_data, test_data, meta)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
pseudocount = 1;
labels = train_data(:, end);
n_training_instances = size(train_data, 1);
attributes = train_data(:, 2);
n_attributes = length(meta.attribute_names) - 1;

count_pos_label = 0;
count_neg_label = 0;
for k = 1:n_training_instances
    if(strcmp(labels{k}, meta.attribute_values{end}{1}))
        count_pos_label = count_pos_label + 1;
    else
        count_neg_label = count_neg_label + 1;
    end
end

for i = 1:n_attributes
    n_possible_attribute_values = size(meta.attribute_values{i}, 2);
    for j = 1:n_possible_attribute_values
        count_attr_pos_label{i}{j} = pseudocount;
        count_attr_neg_label{i}{j} = pseudocount;
        for k = 1:n_training_instances
            if(strcmp(train_data{k, i}, meta.attribute_values{i}{j}))
                if (strcmp(labels{k}, meta.attribute_values{end}{1}))
                    count_attr_pos_label{i}{j} = count_attr_pos_label{i}{j} + 1;
                else
                    count_attr_neg_label{i}{j} = count_attr_neg_label{i}{j} + 1;
                end
            end
        end
    end
end
% computation of the conditional probabilities is done
% training done

%% debugging related

% sum_counts_pos = zeros(n_attributes, 1);
% sum_counts_neg = zeros(n_attributes, 1);
% for i = 1:n_attributes
%     n_possible_attribute_values = size(meta.attribute_values{i}, 2);
%     for j = 1:n_possible_attribute_values
%         sum_counts_pos(i) = sum_counts_pos(i) + count_attr_pos_label{i}{j};
%         sum_counts_neg(i) = sum_counts_neg(i) + count_attr_neg_label{i}{j};
%     end
%     sum_counts_pos(i) = sum_counts_pos(i) - n_possible_attribute_values;
%     sum_counts_neg(i) = sum_counts_neg(i) - n_possible_attribute_values;
% end

%%
n_test_instances = size(test_data, 1);
for k = 1:n_test_instances
    instance = test_data(k, :);

    for l = 1:2
        probability_product = 1;
        log_prob_sum = 0;
        for i = 1:n_attributes
            n_possible_attribute_values = size(meta.attribute_values{i}, 2);
            for j = 1:n_possible_attribute_values
                if(strcmp(test_data{k, i}, meta.attribute_values{i}{j}))
                    if l==1
                        partial = count_attr_pos_label{i}{j}/(count_pos_label + pseudocount * n_possible_attribute_values);
                    else
                        partial = count_attr_neg_label{i}{j}/(count_neg_label + pseudocount * n_possible_attribute_values);
                    end
                end
            end
            probability_product = probability_product * partial;
            log_prob_sum = log_prob_sum + log(partial);
        end
        if l==1
            probability_product_pos = probability_product;
            log_prob_sum_pos = log_prob_sum;
        else
            probability_product_neg = probability_product;
            log_prob_sum_neg = log_prob_sum;
        end
    end
    prob_pos_log_based = exp(log_prob_sum_pos);
    prob_neg_log_based = exp(log_prob_sum_neg);
    if probability_product_pos > probability_product_neg
        test_label_pred{k, 1} = meta.attribute_values{end}{1};
        probability(k, 1) = probability_product_pos/(probability_product_pos + probability_product_neg);
        probability_log_based(k, 1) = prob_pos_log_based/(prob_pos_log_based + prob_neg_log_based);
    else
        test_label_pred{k, 1} = meta.attribute_values{end}{2};
        probability(k, 1) = probability_product_neg/(probability_product_pos + probability_product_neg);
        probability_log_based(k, 1) = prob_neg_log_based/(prob_pos_log_based + prob_neg_log_based);
    end
end

end

