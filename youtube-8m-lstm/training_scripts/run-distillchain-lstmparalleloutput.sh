CUDA_VISIBLE_DEVICES=1 python train.py \
	--train_dir="../model/distillchain_lstmparalleloutput" \
	--train_data_pattern="/Youtube-8M/distillation/frame/train/*.tfrecord" \
	--frame_features=True \
	--feature_names="rgb,audio" \
	--feature_sizes="1024,128" \
	--distillation_features=True \
	--distillation_as_input=True \
	--model=DistillchainLstmParallelFinaloutputModel \
	--rnn_swap_memory=True \
	--lstm_cells="1024,128" \
	--moe_num_mixtures=8 \
	--num_readers=4 \
	--batch_size=128 \
	--num_epochs=3 \
	--base_learning_rate=0.001

