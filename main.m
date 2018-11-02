clear; clc; close all;

train_filename = 'data/lymph_train.arff.txt';
[train_data, metadata] = read_arff_file(train_filename);
test_filename = 'data/lymph_test.arff.txt';
[test_data, ~] = read_arff_file(test_filename);

pseudocount = 1;
%%
labels = train_data(:, end);
n_training_instances = size(train_data, 1);
attributes = train_data(:, 2);
n_attributes = length(metadata.attribute_names) - 1;

count_pos_label = pseudocount;
count_neg_label = pseudocount;
for k = 1:n_training_instances
    if(strcmp(labels{k}, metadata.attribute_values{end}{1}))
        count_pos_label = count_pos_label + 1;
    else
        count_neg_label = count_neg_label + 1;
    end
end

for i = 1:n_attributes
    n_possible_attribute_values = size(metadata.attribute_values{i}, 2);
    for j = 1:n_possible_attribute_values
        count_attr_pos_label{i}{j} = pseudocount;
        count_attr_neg_label{i}{j} = pseudocount;
        for k = 1:n_training_instances
            if(strcmp(train_data{k, i}, metadata.attribute_values{i}{j}))
                if (strcmp(labels{k}, metadata.attribute_values{end}{1}))
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

%%
n_test_instances = size(test_data, 1);
for k = 1:n_test_instances
    instance = test_data(k, :);
    
    for l = 1:2
        probability_product = 1;
        for i = 1:n_attributes
            n_possible_attribute_values = size(metadata.attribute_values{i}, 2);
            for j = 1:n_possible_attribute_values
                if(strcmp(test_data{k, i}, metadata.attribute_values{i}{j}))
                    if l==1
                        partial = count_attr_pos_label{i}{j}/count_pos_label;
                    else
                        partial = count_attr_neg_label{i}{j}/count_neg_label;
                    end
                end
            end
            probability_product = probability_product * partial;
        end
        if l==1
            probability_product_pos = probability_product;
        else
            probability_product_neg = probability_product;
        end
    end
    if probability_product_pos > probability_product_neg
        test_label_pred{k, 1} = metadata.attribute_values{end}{1};
        probability(k, 1) = probability_product_pos/(probability_product_pos + probability_product_neg);
    else
        test_label_pred{k, 1} = metadata.attribute_values{end}{2};
        probability(k, 1) = probability_product_neg/(probability_product_pos + probability_product_neg);
    end
end
test_label_actual = test_data(:, end);