function spike = spike2ins(lsm, spike, id, label, file)

    n = size(lsm.Win, 1);
    m = size(lsm.Win, 2);

    in_neurons = [];
    core_syn_alc = zeros(1, 64);
    for i = 1 : n
       neuron.id = i;
       neuron.core_id = 63;
       neuron.btm_core_id = lsm.ink(i);
       neuron.btm_neurons = []; 
       neuron.btm_syn = 0;
       for j = 1 : m 
           if (lsm.Win(i,j)~=0) 
               core_id = floor((j-1)/(lsm.kx*lsm.ky))+1;
               neuron_id = j-(core_id-1)*lsm.kx*lsm.ky;
               assert(core_id==neuron.btm_core_id, "core_id != neuron.btm_core_id");
               neuron.btm_neurons = [neuron.btm_neurons; neuron_id];
           end
       end
       if (size(neuron.btm_neurons)~=0)
           neuron.btm_syn = core_syn_alc(neuron.btm_core_id);
           core_syn_alc(neuron.btm_core_id) = core_syn_alc(neuron.btm_core_id)+1; 
       end
       in_neurons = [in_neurons; neuron];
    end

n = size(spike,1);
m = size(spike,2);

fid = fopen(file, 'w');

fprintf(fid, ['#LABEL-',num2str(label),'\n']);
fprintf(fid, ['#CASE-ID-',num2str(id),'\n']);
stash_empty = true;
for i = 1 : m
    
    if (stash_empty)
        num_spike = sum(spike(:,i));
        if (num_spike~=0)
            stash_empty = false;
        else
            continue;
        end
    end
    
    for j = 1 : n 
        if (spike(j,i))
            ins = int32(0);
            neuron = in_neurons(j);
            ins = bitor(ins, bitshift(neuron.core_id,24));
            x = int32(neuron.btm_core_id)-1;
            btm_id = int32(0);
            for k = 1 : 6
                if ( bitand(x, int32(2^(k-1)))==0 )
                    btm_id = bitor(btm_id, bitshift(1, k*2-2));
                else
                    btm_id = bitor(btm_id, bitshift(1, k*2-1));
                end
            end
            ins = bitor(ins, bitshift(btm_id,12) );
            ins = bitor(ins, bitshift(neuron.btm_syn,0) );
            fprintf(fid, '%x\n', ins);
        end
    end
    
    if (i~=m)
        fprintf(fid, '#STEPNEXT\n');
    else
        for j= 1 : 10
            fprintf(fid, '#STEPNEXT\n');
        end
        fprintf(fid, '#DONE\n');
    end
end

end