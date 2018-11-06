function n_correctly_classified = get_num_of_correct_classifications(actual_label, predicted_label)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n_instances = size(predicted_label, 1);
n_correctly_classified = 0;
for i = 1:n_instances
    if(strcmp(actual_label{i}, predicted_label{i}))
        n_correctly_classified = n_correctly_classified + 1;
    end
end
end

