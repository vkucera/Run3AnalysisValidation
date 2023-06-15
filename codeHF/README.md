# HF tasks and tests

## HF decay reconstruction tasks
The prepared HF example allows you to run reconstruction of 2-prong secondary vertices and a simple analysis of D<sup>0</sup> mesons. The entire data processing procedure in O<sup>2</sup> involves several steps:
1. Pre-selection of secondary tracks
   * Performed by the [trackIndexSkimCreator](https://github.com/AliceO2Group/O2Physics/blob/master/PWGHF/TableProducer/trackIndexSkimCreator.cxx) class
   in the `o2-analysis-hf-track-index-skim-creator` binary.
   * Includes track selection, candidate preselection, and secondary vertex reconstruction.
1. Reconstruction of 2-prong decay candidates
   * Performed by the [candidateCreator2Prong](https://github.com/AliceO2Group/O2Physics/blob/master/PWGHF/TableProducer/candidateCreator2Prong.cxx) class
   in the `o2-analysis-hf-candidate-creator-2prong` binary.
   * Reconstructs the secondary vertices again and creates 2-prong decay candidates.
   * Performs MC matching of the reconstructed candidates and of the generated particles.
1. Final selection of candidates
   * Performed by the [candidateSelectorD0](https://github.com/AliceO2Group/O2Physics/blob/master/PWGHF/TableProducer/candidateSelectorD0.cxx) class
   in the `o2-analysis-hf-candidate-selector-d0` binary.
   * Appplies cuts on the parameters of the decay topology and track PID cuts.
1. D<sup>0</sup> analysis task
   * Performed by the [taskD0](https://github.com/AliceO2Group/O2Physics/blob/master/PWGHF/D2H/Tasks/taskD0.cxx) class
   in the `o2-analysis-hf-task-d0` binary.
   * Fills histograms with kinematic properties of selected candidates (and matched particles).

Check [this presentation](https://indico.cern.ch/event/932917/contributions/3920363/attachments/2065207/3465791/20200629_PWGHF_report.pdf) to learn more about the design of the underlying data processing scheme that includes skimming, decay reconstruction and analysis.

## Validation

See the `README` in the main repository directory to get familiar with the validation framework.

The default example in the HF validation code performs the D<sup>0</sup> reconstruction analysis using AliPhysics (Run 1+2) and O<sup>2</sup> (Run 3) and produces comparison plots for various decay parameter distributions.

The validation steps are defined in the task configuration script `config_tasks.sh`.

### Select your data

In order to run the analysis with AliPhysics, you need `AliESDs.root` files and specify their location by setting the variables `INPUT_DIR` and `INPUT_FILES` in your input specification script.
To process Monte Carlo data, you also need the corresponding `galice.root` and `Kinematics.root` files.

The default HF input specification script `config_input.sh` contains some predefined input cases with hard-coded paths.
By default `INPUT_CASE=2` is selected.
To run the code with the same input files locally on your machine, download them from the Grid directory `/alice/sim/2018/LHC18a4a2_cent/282099/001/`.
You can use the [`download_from_grid.sh`](../exec/download_from_grid.sh) script for that.

### Run the example

Enter the `codeHF` directory and execute the steering script:

```bash
bash runtest.sh
```

Running all the steps with `INPUT_CASE=2` takes about 40 seconds in total.

The postprocessing step produces several plots `comparison_histos_(...).pdf`, `MC_(...).pdf`.

To confirm that the output of the default settings looks as expected, compare the produced plots with their reference counterparts `(...)_ref.pdf`.

The complete list of commit hashes used to produce the reference plots can be found in `versions_ref.txt`.

## Add a new workflow

- Add the workflow in the task configuration ([`config_task.sh`](config_tasks.sh)):
  - Add the activation switch: `DOO2_...=0         # name of the workflow (without o2-analysis)`.
  - Add the application of the switch in the `MakeScriptO2` function: `[ $DOO2_... -eq 1 ] && WORKFLOWS+=" o2-analysis-..."`.
  - If needed, add lines in the `AdjustJson` function to modify the JSON configuration.
- Add the workflow specification in the workflow database ([`workflows.yml`](workflows.yml)):
  - See the dummy example `o2-analysis-workflow` for the full list of options.
- Add the device configuration in the default JSON file ([`dpl-config_run3.json`](dpl-config_run3.json)).
