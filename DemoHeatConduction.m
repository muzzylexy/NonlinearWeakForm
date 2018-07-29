function DemoHeatConduction
clc; clear; close all;

%% Include package
import Domain.*
import FunctionSpace.*
% addpath IntegrationRule
% addpath Variable

%% Generate domain mesh
domain = DomainBuilder.create('Mesh', 'UnitCube');
% disp(domain)

%% Generate integration rule
% integration_rule_builder = IntegrationRuleBuilderClass('Mesh');
% integration_rule_builder.generateData(domain); % isoparametric 
% % integration_rule_builder.generateData('Some Special Domain'); 
% integration_rule = integration_rule_builder.getIntegrationRuleData();
% 
% if(integration_rule_builder.status_)
%     clear integration_rule_builder;
% end
% 
% % [int_unit, evaluate_jacobian] = integration_rule.quarry(1);
% 
%% Function Space
import Utility.BasicUtility.Order

% function_space = FunctionSpaceBuilder.create('FEM', domain); % default(Linear)
function_space = FunctionSpaceBuilder.create('FEM', domain, {Order.Linear});

%% Function Space (Query - Preprocess)
import FunctionSpace.QueryUnit.FEM.QueryUnit
import Utility.BasicUtility.Region
import Utility.BasicUtility.Procedure

fs_query_unit = QueryUnit();
disp( '>* querying : interior domain, element - 1, parametric position is [0, 0, 0]');
fs_query_unit.setQuery(Region.Interior, 1, [0, 0, 0]);
[non_zeros_id, ~] = function_space.query(fs_query_unit, Procedure.Preprocess);
disp('Non_zeros_id : ');
disp(non_zeros_id);

%% Function Space (Query - Runtime)
import FunctionSpace.QueryUnit.FEM.QueryUnit
import Utility.BasicUtility.Region
import Utility.BasicUtility.Procedure

fs_query_unit = QueryUnit();
disp( '>* querying : boundary domain, element - 2, parametric position is [-1, 1, 0]')
fs_query_unit.setQuery(Region.Boundary, 2, [-1, 1, 0]);
[~, basis_value] = function_space.query(fs_query_unit); %default(Runtime)
N = basis_value{1};
dN_dxi = basis_value{2};
disp('N :');
disp(N);
disp('dN_dxi :');
disp(dN_dxi);

% 
% % %% Demo for FEM integration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % loop for all the integrational unit (element)
% % for ele_id = 1 : integration_rule.num_int_unit_
% %     % quarry the integrational unit (gauss quadrature data) and the jacobian 
% %     % calculating information (Jacobian matrix (F) and which determinant) 
% %     % in each element. 
% %     [int_unit, evaluate_jacobian] = integration_rule.quarry(ele_id);
% %     
% %     % quarry the non_zero_basis (for matrix assembler) and the calculating 
% %     % method for basis function (shape function and which derivatives)
% %     % in each element. 
% %     [non_zero_basis, evaluate_basis] = function_space.quarry(ele_id);
% %     
% %     % get gauss quadrature rule for each isoparametric element.
% %     [num_gauss, gauss_pt, gauss_w] = int_unit();
% %     
% %     % get global assembler id and local stifness matrix size
% %     non_zero_basis_id = non_zero_basis();
% %     
% %     % mass matrix 
% %     mass_mat = zeros(length(non_zero_basis_id));
% %     
% %     % loop gauss point (calculating data in gauss position)
% %     for gauss_id = 1 : num_gauss
% %         xq = gauss_pt(gauss_id,:);
% %         w = gauss_w(gauss_id);
% %         
% %         %%%%%%%%% Assember Part (Start) %%%%%%%%%
% %         % get basis function and which derivatives at gauss point.
% %         [N, dN_dxi] = evaluate_basis(xq);
% %         % get mapping matrix (F) and jacobian.
% %         [dx_dxi, J] = evaluate_jacobian(dN_dxi);
% %         % local mass assembing.
% %         mass_mat = mass_mat + (N'*N) .* (w * J);
% %         %%%%%%%%% Assember Part (End) %%%%%%%%%
% %     end
% %     
% % end
% 
% 
% % 
% % %% Define material property
% % material = MaterialBank('Diffusivity');
% % 
% %% Define variables
% dof_number = 1;
% 
% delta_T = VariableClass('temperature_increment', dof_number);
% T = VariableClass('temperature_total', dof_number, function_space);

% 
% %% Dof manager
% [dof_manager_T, delta_T] = DofManager(delta_T, function_space);

%% Boundary & Initial conditions

% % u1 = 0 for Face 6
% % u2 = 0 for Face 3
% % u3 = 0 for Face 1
% % u1 = lambda for Face 4
% 
% lambda = 0.1;
% prescribed_bc = PrescribedDisplacement([], domain.boundary_connectivity(6,:), [1 1 1 1], [0 0 0 0]);
% prescribed_bc = PrescribedDisplacement(prescribed_bc, domain.boundary_connectivity(3,:), [2 2 2 2], [0 0 0 0]);
% prescribed_bc = PrescribedDisplacement(prescribed_bc, domain.boundary_connectivity(1,:), [3 3 3 3], [0 0 0 0]);
% prescribed_bc = PrescribedDisplacement(prescribed_bc, domain.boundary_connectivity(4,:), [1 1 1 1], lambda*[1 1 1 1]);
% 
% 
% 
% %% Assembling
% [ residual, tangent_matrix ] = Assembler( integration_rule, function_space, material, dof_manager, displacement );
% 
% 

end


