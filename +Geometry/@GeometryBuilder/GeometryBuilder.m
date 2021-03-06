classdef GeometryBuilder
    %GEOMETRYBUILDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function geometry = create(type, name, varargin)
            switch type
                case 'FEM'
                    switch name
                        case 'UnitCube_1_1_1'
                            geometry = Geometry.GeometryBuilder.FEM_UnitCube_1_1_1([]);
                        case 'UnitCube_2_2_2'
                            geometry = Geometry.GeometryBuilder.FEM_UnitCube_2_2_2([]);
                        case 'XML'
                            if(~isempty(varargin))
                                path = varargin{1};
                                geometry = Geometry.GeometryBuilder.FEM_XML( path );
                            else
                                disp('Warning <GeometryBuilder - FEM> - XML');
                                disp('> The XML file path should be assigned!');
                                geometry = []; 
                            end
                            
                        otherwise
                            disp('Warning <GeometryBuilder>!');
                            disp('> name in FEM type was not exist!');
                            disp('> empty geometry builded!');
                            geometry = []; 
                    end
                case 'EFG'
                    disp('Warning <GeometryBuilder>! EFG type not support yet!');
                    disp('> empty geometry builded!');
                    geometry = [];
                case 'RKPM'
                    disp('Warning <GeometryBuilder>! RKPM type not support yet!');
                    disp('> empty geometry builded!');
                    geometry = [];
                case 'IGA'
                    switch name
%                         case 'Rectangle'
%                             geometry = Geometry.GeometryBuilder.IGA_Rectangle(varargin{1});
%                         case 'CylinderSurface'
%                             geometry = Geometry.GeometryBuilder.IGA_CylinderSurface(varargin{1});
%                         case 'Nurbs_Object'
%                             geometry = Geometry.GeometryBuilder.IGA_Tool_Box(varargin{1});
                        case 'XML'
                            if(~isempty(varargin))
                                path = varargin{1};
                                geometry = Geometry.GeometryBuilder.IGA_XML( path );
                            else
                                disp('Warning <GeometryBuilder - IGA> - XML');
                                disp('> The XML file path should be assigned!');
                                geometry = []; 
                            end
                        otherwise
                            disp('Warning <GeometryBuilder>!');
                            disp('> name in IGA type was not exist!');
                            disp('> empty geometry builded!');
                            geometry = []; 
                    end
                otherwise  
                	disp('Error <GeometryBuilder>! check domain input type!');
                    disp('> empty geometry builded!');
                	geometry = [];
            end
        end
    end
    
    
    methods(Static, Access = private)
        geometry = FEM_UnitCube_1_1_1(var);
        geometry = FEM_UnitCube_2_2_2(var);
        geometry = FEM_XML( path );
        
        geometry = IGA_Rectangle(varargin);
        geometry = IGA_CylinderSurface(varargin);
        geometry = IGA_Tool_Box(varargin);
        geometry = IGA_XML( path );
    end
end

