# Copyright 2024 The Google Research Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash
set -e
set -x

# Make sure arguments were supplied
if [[ $# < 1 ]] ; then
    echo 'Usage: run.sh <LOG_DIR>'
    exit 1
fi

# Arguments
LOG_DIR=$1

# Installs scenic library.
git clone https://github.com/google-research/scenic.git
cd scenic
pip3 install .
cd ../

# Install invariant_slot_attention requirements
pip3 install -r invariant_slot_attention/requirements.txt

# Train on Tetrominoes dataset
# python -m invariant_slot_attention.main \
#     --config invariant_slot_attention/configs/tetrominoes/equiv_transl.py \
#     --workdir $LOG_DIR/tetrominoes/equiv_transl/
# python -m invariant_slot_attention.main \
#     --config invariant_slot_attention/configs/tetrominoes/baseline.py \
#     --workdir $LOG_DIR/tetrominoes/baseline/

# Train on CLEVR dataset
# python -m invariant_slot_attention.main \
#     --config invariant_slot_attention/configs/clevr_with_masks/equiv_transl.py \
#     --workdir $LOG_DIR/clevr_with_masks/equiv_transl/
python -m invariant_slot_attention.main \
    --config invariant_slot_attention/configs/clevr_with_masks/baseline.py \
    --workdir $LOG_DIR/clevr_with_masks/baseline/
python -m invariant_slot_attention.main \
    --config invariant_slot_attention/configs/clevr_with_masks/equiv_transl_scale.py \
    --workdir $LOG_DIR/clevr_with_masks/equiv_transl_scale/
python -m invariant_slot_attention.main \
    --config invariant_slot_attention/configs/clevr_with_masks/equiv_transl_rot_scale.py \
    --workdir $LOG_DIR/clevr_with_masks/equiv_transl_rot_scale/

