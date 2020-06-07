function lsm = lsm2json(lsm)

%  input 
    n = size(lsm.Win, 1);
    m = size(lsm.Win, 2);
    node.neuron = [];
    node.core = 63;
    node.bottom_core = 0;
    node.synapse = [];
    nodes = [];

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
               core_id = floor((j-1)/(lsm.kx*lsm.ky));
               neuron_id = j-(core_id-1)*lsm.kx*lsm.ky;
               assert(core_id~=neuron.btm_core_id, "core_id != neuron.btm_core_id");
               neuron.btm_neurons = [neuron.btm_neurons; neuron_id];
           end
       end
       if (size(neuron.btm_neurons)~=0)
           neuron.btm_syn = core_syn_alc(neuron.btm_core_id);
           core_syn_alc(neuron.btm_core_id) = core_syn_alc(neuron.btm_core_id)+1; 
       end
       in_neurons = [in_neurons; neuron];
    end  
    fid = fopen("./lsm.json", 'w');
    fprintf(fid, '{\n');
    for i = 1 : size(in_neurons,1)
        fprintf(fid, '"core%d_%d"       : {\n', 63, i);
        fprintf(fid, '\t"type"          : "input",\n');
        fprintf(fid, '\t"core"          : %d,\n'   , 63 );
        fprintf(fid, '\t"neuron"\t      : ["%d"],\n', in_neurons(i).id-1);
        fprintf(fid, '\t"bottom_core"   : %d,\n'    , in_neurons(i).btm_core_id-1);
        fprintf(fid, '\t"bottom_synapse": ["%d"]\n', in_neurons(i).btm_syn);
        if (i==size(in_neurons,1))
            fprintf(fid, '},\n');
        else 
            fprintf(fid, '},\n');
        end
    end
    
    for z = 1 : lsm.kz
        neuron.core_id = z;
        neuron.btm_core_id = lsm.ckk(z);
        btm = lsm.ckk(z);
        neuron.id  = sprintf('"0-%d"', lsm.kx*lsm.ky-1);
        neuron.btm_syn = sprintf('"%d-%d"',core_syn_alc(btm), core_syn_alc(btm)+lsm.kx*lsm.ky-1 );
        core_syn_alc(btm) = core_syn_alc(btm) + lsm.kx*lsm.ky;

        fprintf(fid, '"core%d_%d":{\n', z-1, btm-1);
        fprintf(fid, '"type"           : %s,\n', '"LIF"');
        fprintf(fid, '"core"           : %d,\n', z-1);
        fprintf(fid, '"neuron"         : [%s],\n', neuron.id);
        fprintf(fid, '"bottom_core"    : %d,\n', btm-1);
        fprintf(fid, '"bottom_synapse" : [%s]\n', neuron.btm_syn);
        if (z == lsm.kz)
            fprintf(fid, '}\n');
        else
            fprintf(fid, '},\n');
        end
    end
        
    
    fprintf(fid, '}');

end 
