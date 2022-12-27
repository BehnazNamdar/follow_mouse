
function follow_mouse(radius)


% The function will take one input, radius, which will determine...
%  the radius of a circle.

% 1- Draw a black circle in the center of the screen.
% 2- Using KbCheck, wait for the user to press a key...
%   If the user presses R, the ball will turn red;
%   if they press G the ball should turn green;
%   if they press B the ball turn blue.



% 3- The ball will begin moving towards the mouse position.
%    Only move the ball 2 pixels each frame,
%    do not jump right to the location of the mouse.
%    The ball will follow the mouse around the screen until the user clicks the mouse,
%    when the program will end and the screen will clear.
% 4- While the ball is moving, the user may press R, G, or B to change the color of the circle accordingly.






%-----------------------------
% setting parameters of window
%-----------------------------
Screen('Preference', 'SkipSyncTests', 1);
windowColor = [128 128 128];
windowSize = [0 0 700 500];

% set color of the first circle
circleColor = [0 0 0];

% get number of screen
scrNum = Screen('Screens');

% open a window
[wPtr , rect ] = Screen('OpenWindow' , scrNum, windowColor , windowSize);




%----------
% PsychHID
%----------
devices = PsychHID('Devices'); %PsychHID only checks for USB devices on startup.


%-----------------------------
% setting text message in the beginning of the experiment
%-----------------------------

Screen('TextFont',wPtr,'Helvetica');
Screen('TextSize',wPtr,17);
Screen('TextStyle',wPtr,0);
Screen('DrawText',wPtr, 'Welcome to the yourinitials_session6',100,100,[0 0 0]);
Screen('DrawText',wPtr, 'At first you will see a black circle in the center of the screen',100,130,[0 0 0]);
Screen('DrawText',wPtr, 'you should press ''r'' to turn the color of circle to RED',100,160,[150 0 0]);
Screen('DrawText',wPtr, 'you should press ''g'' to turn the color of circle to GREEN',100,180,[0 200 0]);
Screen('DrawText',wPtr, 'you should press ''b'' to turn the color of circle to BLUE',100,200,[0 0 200]);
Screen('DrawText',wPtr, 'Then the ball will follow mouse position,',100,230,[0 0 0]);
Screen('DrawText',wPtr, 'you can click r,g,b keys to change its color during its movement',100,260,[0 0 0]);
Screen('DrawText',wPtr, 'And click mouse to end task',100,290,[0 0 0]);
Screen('Flip' , wPtr );

WaitSecs(5);

Screen('TextFont',wPtr,'Helvetica');
Screen('TextSize',wPtr,20);
Screen('TextStyle',wPtr,1);
Screen('DrawText',wPtr, 'Click mouse when you are ready',150,290,[0 0 0]);
Screen('Flip' , wPtr );


% Click mouse to begin
%---------------------------------

buttons = 0;

while ~buttons
    [x,y,buttons] = GetMouse();
end

%-----------------------------
% setting parameters for centering
%-----------------------------
screenWidth = rect(3);           % This is width of screen
screenHeight = rect(4);          % This is hieght of screen
screenCenterX = screenWidth/2;   % This is center of the width of the screen
screenCenterY = screenHeight/2;  % This is center of the hieght of the screen


circleRectLeft = screenCenterX - radius;     % first rect of circle
circleRectTop = screenCenterY - radius;     % second rect of circle
circleRectRight = screenCenterX + radius;    % third rect of circle
circleRectBottom = screenCenterY + radius;  % forth rect of circle
circleRect = [circleRectLeft, circleRectTop, circleRectRight, circleRectBottom]; % rect of circle



%----------------------------------------------------------------------
% draw a circle in the center of the screen with radius equal to radius
%----------------------------------------------------------------------
Screen('FillOval' , wPtr , circleColor , circleRect );
Screen('Flip' , wPtr );



%----------------------------------------------------------------------
% Change color of the center circle
%----------------------------------------------------------------------

RestrictKeysForKbCheck([KbName('r'), KbName('g'), KbName('b')]);

keyIsDown = 0;

while ~keyIsDown
    [keyIsDown,secs,keyCode]=KbCheck(-1);
end

pressedKey = KbName(find(keyCode));

if pressedKey == 'r'
    
    circleColor = [255 0 0];
    
    
elseif pressedKey == 'g'
    
    circleColor = [0 255 0];
    
    
elseif pressedKey == 'b'
    
    circleColor = [0 0 255];
end
keyIsDown = 0;

Screen('FillOval' , wPtr , circleColor , circleRect );
Screen('Flip' , wPtr );




%----------------------------------------------------------------------
% Move the circle towards the mouse position
%----------------------------------------------------------------------

xIncrement = 5;
yIncrement = 5;
buttons = 0;
keyIsDown = 0;

while ~keyIsDown
    
    while ~buttons
        
        [mX,mY,buttons]=GetMouse;
        
        changRect = [sign(mX - circleRect(1)), sign(mY - circleRect(2)) , sign(mX - circleRect(1)), sign(mY - circleRect(2))];
        
        
        %change color
        [keyIsDown,secs,keyCode]=KbCheck(-1);
        pressedKey = KbName(find(keyCode));
        
        if pressedKey == 'r'
            
            circleColor = [255 0 0];
            
            
        elseif pressedKey == 'g'
            
            circleColor = [0 255 0];
            
            
        elseif pressedKey == 'b'
            
            circleColor = [0 0 255];
        end
        
        
        circleRect = circleRect + [xIncrement , yIncrement , xIncrement , yIncrement].* changRect ;
        Screen('FillOval',wPtr,circleColor,circleRect);
        Screen('Flip',wPtr)
        
    end
   keyIsDown = 1 ;
end


end




