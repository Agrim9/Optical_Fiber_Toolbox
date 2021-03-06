function hand = phase_vel(MODES, caption, color)
% Displays modal curves for the MODES array.
% 
% Each element in MODES contains fields ARG, NEFF, ARGTYPE and PAR that are
% needed for this function.

hand = [];
if isempty(MODES), return; end; 

if nargin == 1
    caption = '';
end

assert(ischar(caption));

% If parameter is wavelength, the modal curves can be coloured according to
% this wavelength.
parIsLambda = strcmpi(partype(MODES), 'wvl');

argmin = Inf;
argmax = -Inf;
neffmin = Inf;
neffmax = -Inf;
c=3e8;

for i = 1:numel(MODES)
    %if parIsLambda
    %    colour = colourVsLambda(MODES(i).par);
    %else
    %    colour = 'k';
    %end;
    hold on;
    h = plot(MODES(i).ARG, c./MODES(i).NEFF, 'Color', color, 'LineWidth', 1);
    hand = [hand h]; %#ok<AGROW>
    drawnow;
    argmin = min(argmin, min(MODES(i).ARG));
    argmax = max(argmax, max(MODES(i).ARG));
    neffmax = max(c/neffmax, max(c./MODES(i).NEFF));
    neffmin = min(c/neffmin, min(c./MODES(i).NEFF));
end

ylabel('Velocity');
if strcmpi(MODES(1).argtype, 'WVL')
    xlabel('Wavelength, nm');
elseif strcmpi(MODES(1).argtype, 'DIA')
    xlabel('Diameter, \mu{}m');
elseif strcmpi(MODES(1).argtype(1:2), 'VP')
    xlabel('V-parameter');
else
    error('Invalid argtype: %s\n', MODES(1).argtype);
end;

title(caption);
    
neffRange = neffmax - neffmin;
axis([argmin argmax neffmin - 0.1 * neffRange neffmax + 0.1 * neffRange]);
grid on;

