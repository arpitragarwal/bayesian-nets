function [label, prob] = get_tan_predictions(test_data, meta, cond_prob_tables, edges)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n_instances = size(test_data, 1);
n_attributes = size(test_data, 2) - 1;
for k = 1:n_instances
    instance = test_data(k, :);
    for i = 1:n_attributes
        unique_x = meta.attribute_values{i};
        for j = 1:length(unique_x)
            if strcmp(instance(i), unique_x(j))
                test_data_indices(k, i) = j;
            end
        end
    end
end

% for each instance go through all vertices
% for each vertex - identify parent, find parent index, multiply prob.
for k = 1:n_instances
    instance = test_data(k, :);
    log_cpt_value = zeros(1, length(meta.attribute_values{end}));
    
    for curr_attribute = 1:n_attributes
        cpt = cond_prob_tables{curr_attribute};
        curr_attr_idx   = test_data_indices(k, curr_attribute);
        if curr_attribute == 1
            cpt_value(:) = cpt(curr_attr_idx, :);
        elseif curr_attribute <= n_attributes
            parent_attribute = edges(edges(:, 2) == curr_attribute, 1);
            parent_attr_idx = test_data_indices(k, parent_attribute);
            cpt_value(:) = cpt(curr_attr_idx, parent_attr_idx, :);
        end
        log_cpt_value = log_cpt_value + log(cpt_value);
    end
    py = cond_prob_tables{end};
    log_cpt_value = log_cpt_value + log(py);
    probabilities = exp(log_cpt_value);
    if probabilities(1) > probabilities(2)
        label(k, 1) = meta.attribute_values{end}(1);
        prob(k, 1) = probabilities(1)/sum(probabilities);
    else
        label(k, 1) = meta.attribute_values{end}(2);
        prob(k, 1) = probabilities(2)/sum(probabilities);
    end
end
end

