
GPU_ID="0"
EVERY=2000
MODEL=LstmMemoryModel
MODEL_DIR="../model/audio_lstmmemory1024_layer1_moe8"

start=$1
DIR="$(pwd)"

for checkpoint in $(cd $MODEL_DIR && python ${DIR}/training_utils/select.py $EVERY); do
	echo $checkpoint;
	if [ $checkpoint -gt $start ]; then
		echo $checkpoint;
		CUDA_VISIBLE_DEVICES=$GPU_ID python eval.py \
			--train_dir="$MODEL_DIR" \
			--model_checkpoint_path="${MODEL_DIR}/model.ckpt-${checkpoint}" \
			--eval_data_pattern="/Youtube-8M/data/frame/validate/validatea*" \
			--frame_features=True \
      --feature_names="audio" \
      --feature_sizes="128" \
			--model=$MODEL \
      --lstm_cells=512 \
      --lstm_layers=1 \
      --moe_num_mixtures=8 \
      --rnn_swap_memory=False \
			--batch_size=128 \
			--run_once=True
	fi
done

