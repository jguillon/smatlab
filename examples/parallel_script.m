
N_RUNS = 100;

N = 10000;
L = 1000;          % Signal length
Fs = 250;            % Sampling frequency
T = 1/Fs;
f = Fs*(0:(L/2))/L;

pool = parpool;
fprintf('\nOne run is one dot, one dot is one run...');

ellapsedTime = zeros(N_RUNS,1);
for j=1:N_RUNS
    
    time = tic;
    res = zeros(N,1);
    parfor i=1:N
        %%% Signal creation
        t = (0:L-1)*T;
        S = rand()*sin(2*pi*rand()*Fs*t) + rand()*sin(2*pi*rand()*Fs*t);
        X = S + 2*randn(size(t));
        %%% DFT computation
        Y = fft(X);
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        %%% Peak detection
        [~, argmax] = max(P1);
        res(i) = f(argmax);
    end
    ellapsedTime(j) = toc(time);

    fprintf('.');
    
end

delete(pool);
fprintf('\nAverage time to run one loop of size %d : %.4f seconds.\n', N, mean(ellapsedTime));