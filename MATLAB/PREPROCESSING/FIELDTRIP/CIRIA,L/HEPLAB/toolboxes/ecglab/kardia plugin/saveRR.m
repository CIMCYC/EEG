% saveRR - script to Save RR intervals obtained from ecglabRR R peak
% detection tool programmed by Joao Carvalho
%
% Copyright (C) 2007 2008 Pandelis Perakakis, University of Granada
% peraka@ugr.es
%
% This file is part of Kardia.
%
% Kardia is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Kardia is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Kardia.  If not, see <http://www.gnu.org/licenses/>.
%
if ecg_sinal==-1
    set(tx_mensagens, 'String', 'There is no ECG currently opened!');
    return
else
    clear rr
    rr=ecg_ondar;
    rr=rr./samplerate_ecg;
    set(tx_mensagens, 'String', 'The markings and R-R intervals have been saved!');
    % Save ECG
    point=find(filename=='.');filename2=[filename(1:point-1),'_rr.mat']; %adapt extension
    save (filename2, 'rr');
    % plot RR time series
    rr(1)=[];
    x=length(rr);
    figure ('name',filename); plot (diff(rr))
    title('RR intervals')
    xlabel('Beats')
    ylabel('Seconds')
end
