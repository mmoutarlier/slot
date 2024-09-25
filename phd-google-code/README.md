# Code from Google

This repository contains original and/or modified code imported from Google projects,
such as [google-research](https://github.com/google-research/google-research).

## Invariant Slot Attention

### Requirements

Download the relevent datasets and store them somewhere on your machine, using the 
following commands:

```bash
# Tetrominoes dataset (used as demo)
wget https://storage.googleapis.com/multi-object-datasets/tetrominoes/tetrominoes_train.tfrecords
# CLEVR dataset (optional)
wget https://storage.googleapis.com/multi-object-datasets/clevr_with_masks/clevr_with_masks_train.tfrecords
```

The code can actually run without explicitly downloading the datasets, but it will be
much slower (as it streams the dataset at every epoch).

### Quick Start

1. Create and/or activate a new Python virtual environment (tested with 3.11.8).

2. Modify the `invariant_slot_attention/lib/input_pipeline.py` files by replacing the 
datasets' `PATH_` variables with the actual path on your disk.

3. Modify the mode and training configurations (especially `batch_size`) if required, by
changing the `invariant_slot_attention/configs/<dataset>/<equiv_...>.py` files.
    * For Tetrominoes, the default configuration can be used on RTX 3090.
    * For CLEVR, the `batch_size` must be set to 32 on RTX 3090.

4. From this repository's root, run the `invariant_slot_attention/run.sh` script:

    ```bash
    # Replace <LOG_DIR> by the directory of your choice
    ./invariant_slot_attention/run.sh <LOG_DIR>
    ```

5. Otherwise, run these commands manually at the root of this repository:

    ```bash
    # Clone and install Google's scenic library
    git clone https://github.com/google-research/scenic
    cd scenic
    pip3 install .
    cd ../

    # Install the requirements specific to invariant_slot_attention
    pip3 install -r invariant_slot_attention/requirements.txt

    # Run the demo code (change the --config option for another dataset and/or model)
    python -m invariant_slot_attention.main --config invariant_slot_attention/configs/tetrominoes/equiv_transl.py --workdir tmp/
    ```

### RCP-EPFL Cluster

1. To run an interactive job, use the following command:

    ```bash
    kubectl create -f invariant_slot_attention/job_interactive.yaml
    ```

2. To train all models, use the following command:

    ```bash
    kubectl create -f invariant_slot_attention/job_train.yaml
    ```

## References

- [google-research](https://github.com/google-research/google-research)
- [scenic](https://github.com/google-research/scenic)
- [multi-objects-datasets](https://github.com/google-deepmind/multi_object_datasets)
- [slot-attention-video](https://github.com/google-research/slot-attention-video)
