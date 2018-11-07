function print_labels_and_probabilities(predicted_class, actual_class, probabilities, n_correctly_classified)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for k = 1:length(predicted_class)
    predicted_class{k} = replace(predicted_class{k}, "'", "");
    actual_class{k} = replace(actual_class{k}, "'", "");
    display([predicted_class{k}, ' ', actual_class{k}, ' ', num2str(probabilities(k), 12)]);
end
fprintf('\n');
display(num2str(n_correctly_classified));
fprintf('\n');
end

