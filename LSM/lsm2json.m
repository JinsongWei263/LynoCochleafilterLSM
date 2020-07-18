function lsm = lsm2json(lsm, path)

%  input 
    regList = ...
   ['"RegList" :{' 10 ...
    '"cf"            : 100,' 10 ...
    '"sw"            : 2,' 10 ...
    '"pw"            : 20,' 10 ...
    '"ITM"           : 0,' 10 ...
    '"REF"           : 1,' 10 ...
    '"REFT"          : 2,' 10 ...
    '"timer_window"  : 21,' 10 ...
    '"timer_step"    : 1,' 10 ...
    '"output_core"   : 1' 10 ...
    '},' 10];
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
       neuron.core_id = 64;
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
    config_file =[path '/config.json'];
    fid = fopen(config_file, 'w');
    
    fprintf(fid, '{\n');
    fprintf(fid, '%s', regList);
    
%     for i = 1 : size(in_neurons,1)
%         fprintf(fid, '"core%d_%d"       : {\n', 63, i);
%         fprintf(fid, '\t"type"          : "input",\n');
%         fprintf(fid, '\t"core"          : %d,\n'   , 63 );
%         fprintf(fid, '\t"neuron"\t      : ["%d"],\n', in_neurons(i).id-1);
%         fprintf(fid, '\t"bottom_core"   : %d,\n'    , in_neurons(i).btm_core_id-1);
%         fprintf(fid, '\t"bottom_synapse": ["%d"]\n', in_neurons(i).btm_syn);
%         if (i==size(in_neurons,1))
%             fprintf(fid, '},\n');
%         else 
%             fprintf(fid, '},\n');
%         end
%     end
    lsmneurons = [];
    for z = 1 : lsm.kz
        neuron.core_id = z;
        neuron.btm_core_id = lsm.ckk(z);
        btm = lsm.ckk(z);
        neuron.id  = sprintf('"0-%d"', lsm.kx*lsm.ky-1);
        neuron.btm_syn = sprintf('"%d-%d"',core_syn_alc(btm), core_syn_alc(btm)+lsm.kx*lsm.ky-1 );
        core_syn_alc(btm) = core_syn_alc(btm) + lsm.kx*lsm.ky;
        lsmneurons = [lsmneurons; neuron];
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

    fclose(fid);
    fid = fopen([path,'/weight.json'], 'w');
    mn = ceil(m/n);
    lk = floor(lsm.kx*lsm.ky/mn);
    fprintf(fid, '{\n');
    for i = 1 : n
        neuron = in_neurons(i);
        left = (neuron.btm_core_id-1) * lsm.kx*lsm.ky +1;
        right = left + lsm.kx*lsm.ky-1;
        weight = lsm.Win(i, left:right);
        fprintf(fid, '"core%d_syn%d" : {\n', neuron.btm_core_id-1, neuron.btm_syn);
        fprintf(fid, '"core" : %d,\n', neuron.btm_core_id-1);
        fprintf(fid, '"synapse" : %d,\n', neuron.btm_syn);
        fprintf(fid, '"neuron"  : ["%d-%d"],\n', 0, lsm.kx*lsm.ky-1);
        stringw = sprintf('%d, ', weight);
        stringw = stringw(1:end-2);
        fprintf(fid, '"weight"  : [%s]\n', stringw);
        fprintf(fid, '},\n');
    end
    
    for z = 1 : lsm.kz
        neuron = lsmneurons(z);
        fprintf(fid, '"core%d_syn%s" : {\n', neuron.btm_core_id-1, neuron.btm_syn(2:end-1));
        fprintf(fid, '"core" : %d,\n', neuron.btm_core_id-1);
        fprintf(fid, '"neuron": [%s],\n', neuron.id);
        fprintf(fid, '"synapse" : [%s],\n', neuron.btm_syn);
        weight = lsm.W((z-1)*lsm.kx*lsm.ky+1:z*lsm.kx*lsm.ky ,(neuron.btm_core_id-1)*lsm.kx*lsm.ky+1:neuron.btm_core_id*lsm.kx*lsm.ky);
        weight = reshape(weight', [1, lsm.kx*lsm.ky*lsm.kx*lsm.ky]);
        stringw = sprintf('%d, ', weight);
        stringw = stringw(1:end-2);
        fprintf(fid, '"weight" : [%s]\n', stringw);
        if (z ~= lsm.kz)
            fprintf(fid, '},\n');
        else
            fprintf(fid, '}\n');
        end
    end
    
    fprintf(fid, '}\n');

    spike_id = randi(2000);
    spike_file = ['./data/spike/spike',num2str(spike_id),'mat.mat'];
    load(spike_file);
    spikeins_file = [path, '/inspike.in'];
    spike2ins(lsm, spike, spike_id, spike_label, spikeins_file);
end 
