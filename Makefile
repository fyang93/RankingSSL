DATA_DIR=${HOME}/data/imagenet-100
LOG_DIR=${HOME}/data/log
SAVE_DIR=${HOME}/data/ckpts

train:
	python -m torch.distributed.launch --nproc_per_node=2 main.py \
	-a vit_base -b 128 \
	--lr=1.5e-4 --weight-decay=.1 --weight-decay-end=.1 \
	--opt=adamw \
	--aug-spatialconsistent-color \
	--loss byol \
	--epochs=300 --warmup-epochs=40 --save-freq 5 \
	--opt-betas 0.9 0.95 \
	--drop_path_rate 0.1 --attn_drop_rate 0. \
	--layer_scale_init_value 0.1 --class_attention_layers 2 \
	--mask-ratio 0.8 --num-masks 5 \
	--ema-momentum 0.996 \
	--proj-dim 256 \
	--dist-url 'tcp://localhost:10001' \
	--multiprocessing-distributed \
	--seed 0 \
	--log_dir $(LOG_DIR) \
	--output_dir $(SAVE_DIR) \
	$(DATA_DIR)