% classical approximate message passing (AMP) algorithm
% max T iterations
% column-wise iteration for 2D signals


function [hat_h] = amp_core(y,Phi,Psi,T,epsilon,stop_earlier,show_detail)
    %y: M*1 signal after measurement
    %A: Phi * Psi
    %T: max iteration num
    %epsilon: min iteration step
    %alpha: usually alpha=1 for this fucntion
    %...flag==0 for noiseless
    %stop_earlier: no need for run all num iteration...
    %...if less than epsilon, break.  
    %h: N*1 sparse signal reconstruction result
    
    
    [M, N] = size(Phi);
   
    A = Phi * Psi';
 
    h0 = zeros(N,1);
    b0 = y;
    

    %iteration
    % h0,b0¡úh,b
    for t = 1:1:T
        
        lambda0 = 1*norm(b0,2) / sqrt(M);
        
        c0 = nnz(h0(:)~=0) / M;

        r0 = A' * b0;
        
        hat_h = amp_eta_t(r0 + h0, lambda0);
 
        s = A * hat_h;
        
        b = y - s + b0 * c0;
        
        %recording MSE and NMSE change
        epsilon_now = norm((hat_h - h0),2) / (norm(hat_h,2));
        
        % show detail
        if show_detail == 1
            fprintf('The %d-th iteration,epsilon = %4f \n',t,epsilon_now);
        end
        
        % stop earlier
        if(epsilon_now < epsilon)
            if(stop_earlier==1)       
                if show_detail == 1
                    fprintf('Stops after %d iterations.\n',t); 
                end
                break;
            end
        end      
        h0 = hat_h;
        b0 = b;
    end
    
    %hat_x = Psi' * hat_h;

end

