% Copyright 2015-2016 The MathWorks, Inc.
%
% Adopted by Ioannis Georgilas 2017
% University of Bath
%
% Define MATLAB class that inherits from arduinoio.LibraryBase
classdef StepperMotorAddOn < arduinoio.LibraryBase
    
    % Define command IDs for all public methods of the class object
    properties(Access = private, Constant = true)
        STEPPERMOTOR_INIT = hex2dec('01');
        STEPPERMOTOR_MOVE = hex2dec('02');
    end
    
    % Override below constant properties to include any 3P source
    % into the compiled server code
    properties(Access = protected, Constant = true)
        LibraryName = 'BathUniversity/StepperMotorAddOn'
        DependentLibraries = {}
        ArduinoLibraryHeaderFiles = {}
        CppHeaderFile = fullfile(arduinoio.FilePath(mfilename('fullpath')), 'src', 'StepperMotorAddOn.h')
        CppClassName = 'StepperMotorAddOn'
    end
    
    methods
        function obj = StepperMotorAddOn(parentObj,inputPins)
            % This is the class constructor.
            % It takes as an input the four pins that are used for driving
            % the bipolar motor.
            % An example of how to call the constructor:
            %
            % stepper = addon(arduino_obj,'BathUniversity/StepperMotorAddOn',{'D13','D12','D9','D8'})
            %
            try
                cmdID = obj.STEPPERMOTOR_INIT;
                
                obj.Parent = parentObj;
                obj.Pins = inputPins;

                % Convert pins from string to numbers, e.g. 'D2' -> 2
                terminals = getTerminalsFromPins(obj.Parent,inputPins);
                
                % Send the command to setup the stepper motor pins
                output = sendCommand(obj, obj.LibraryName, cmdID, terminals);
                char(output')
            catch e
                throwAsCaller(e);
            end
        end
        
        % Define methods to call 3P functions
        function out = MoveStepper(obj,varargin)
            % MoveStepper(stepperMotor,Direction,Frequency,Steps)
            %
            % This function will control the windings of a bipolar stepper
            % motor, defined by stepperMotor, towards the Direction, at a
            % Frequency, for a number of Steps.
            %
            % stepperMotor: the object of the stepper motor to control. Can be initiated with the command:
            % <Pulse Train Object> = addon(<arduino object>,'BathUniversity/PulseTrainAddOn', {<List of Digital Pins>})
            %
            % For the shield board of the Mechatronics Unit it is
            % stepperMotor = addon(arduino_obj,'BathUniversity/StepperMotorAddOn',{'D13', 'D12', 'D9', 'D8'})
            % 
            % Direction: 0 or 1
            %
            % Frequency: in Hz 
            %
            % Steps: number of steps to travel
            
            % Set the command to a move command
            cmdID = obj.STEPPERMOTOR_MOVE;
            
            % Get the pins for the motion from the stepper object
            data2Send(1:4) = getTerminalsFromPins(obj.Parent,obj.Pins);
            
            % Parse the direction from the inputs and set the relevant byte
            Direction = varargin{1};
            data2Send(5)=Direction;
            
            % Parse the frequency from the inputs and  cast it into two
            % bytes (you can only send bytes, i.e. <255, with commandHandler)
            Freq = varargin{2};
            data2Send(6:7) = typecast(uint16(Freq),'uint8');
            
            % Parse the Pulses from the inputs and  cast it into two
            % bytes (you can only send bytes, i.e. <255, with commandHandler)
            Steps = varargin{3};
            data2Send(8:9) = typecast(uint16(Steps),'uint8');
            
            % Send the command to the Arduino with the relevant data
            output = sendCommand(obj, obj.LibraryName, cmdID, data2Send);
            out = [char(output') ': ' num2str(Steps)];
        end
    end
end
