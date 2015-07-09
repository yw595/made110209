
% this file tests MADE with a simple metabolic model over
% three conditions

% load a test COBRA model
test_cobra_model

% convert the model to an ELF model (optional)
m = make_elf_model(model);

% gene names corresponding to the rows in fold_change and p
gene_names = {'transA','lefty','righty1','righty2A'};

fold_change = [0.5, 0.99
               0.3, 1.01
               2.3, 1.5 
               2.3, 1.5 ];

p = [0.02, 0.96
     0.01, 0.94
     0.03, 0.09
     0.03, 0.09];


% set condition-specific bounds; change the input of A from -10
% in the first condition to -7 and -8.3 is second and third conditions
bounds{1}.lb = m.lb;
bounds{1}.ub = m.ub;

bounds{2}.lb = m.lb;
bounds{2}.ub = m.ub;
bounds{2}.lb(1) = -7;

bounds{3}.lb = m.lb;
bounds{3}.ub = m.ub;
bounds{3}.lb(1) = -8;

% run MADE
[gene_states,genes,sol,models] = made(m,fold_change,p,1/3, ...
                                      'bounds',bounds, ...
                                      'gene_names',gene_names, ...
                                      'method','milp')

