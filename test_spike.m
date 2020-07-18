clear ;
load lsmout;

spike_index = 835;
load(['spike', num2str(spike_index), 'mat.mat']);

in_ch = size(lsm.Win, 1);
lsm_ch= size(lsm.Win, 2);

in_ch_spike = zeros(1, in_ch);
lsm_get_spikes_num = zeros(64, 512);

catch_len = 130;

remove_empty = true;

len = size(spike,2);

lsm.insyn_id = zeros(1,in_ch);
syn_id_alloc = ones(1, 64);
for i = 1 : in_ch
    core_id = lsm.ink(i);
    lsm.insyn_id(i) = syn_id_alloc(core_id);
    syn_id_alloc(core_id) = syn_id_alloc(core_id) + 1;
end

for i= 1 : len
    if remove_empty
        if (sum(spike(:,i))==0 )
            continue;
        else
            remove_empty = false;
        end
    end
    if (catch_len==0)
        break;
    end
    in_ch_spike = in_ch_spike + spike(:,i);
    for j = 1 : in_ch
        core_id = lsm.ink(j);
        syn_id  = lsm.insyn_id(j);
        lsm_get_spikes_num(core_id, syn_id)= ...
                        lsm_get_spikes_num(core_id, syn_id)+spike(j,i);
    end
    catch_len= catch_len -1;
end


