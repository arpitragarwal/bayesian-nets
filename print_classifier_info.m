function print_classifier_info(meta, edges)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    % this is for naive bayes
    for i = 1:length(meta.attribute_names) - 1
        meta.attribute_names{i} = replace(meta.attribute_names{i}, "'", "");
        disp([meta.attribute_names{i}, ' class']);
    end
else
    % this is for TAN
    for i = 1:length(meta.attribute_names) - 1
        meta.attribute_names{i} = replace(meta.attribute_names{i}, "'", "");
    end
    for i = 1:length(meta.attribute_names) - 1
        parent_idx = edges(edges(:, 2)==i, 1);
        if ~isempty(parent_idx)
            disp([meta.attribute_names{i}, ' ', meta.attribute_names{parent_idx}, ' class']);
        else
            disp([meta.attribute_names{i}, ' class']);
        end
    end
end
fprintf('\n')
end